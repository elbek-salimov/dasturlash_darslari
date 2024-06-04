import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../local/storage_repository.dart';
import '../../models/forms_status.dart';
import '../../models/network_response.dart';
import '../../models/user/user_model.dart';
import '../../repository/auth/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(AuthState.init()) {
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<LoginUserEvent>(_loginUser);
    on<RegisterUserEvent>(_registerUser);
    on<SignInWithGoogleEvent>(_googleSignIn);
    on<LogOutUserEvent>(_logOutUser);
  }

  final AuthRepository authRepository;

  _checkAuthentication(CheckAuthenticationEvent event, emit) async {
    User? user = FirebaseAuth.instance.currentUser;

    debugPrint("CURRENT USER:$user");
    if (user == null) {
      emit(state.copyWith(status: FormsStatus.unauthenticated));
    } else {
      emit(state.copyWith(status: FormsStatus.authenticated));
    }
  }

  _loginUser(LoginUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
    await authRepository.logInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    if (networkResponse.errorText.isEmpty) {
      // String? myToken = await FirebaseMessaging.instance.getToken();
      // StorageRepository.setString(key: "fc_token", value: myToken ?? "");
      UserCredential userCredential = networkResponse.data as UserCredential;

      UserModel userModel =
      state.userModel.copyWith(authUid: userCredential.user!.uid);

      emit(state.copyWith(
          status: FormsStatus.authenticated, userModel: userModel));
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _registerUser(RegisterUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse =
    await authRepository.registerWithEmailAndPassword(
      email: event.userModel.email,
      password: event.userModel.password,
    );
    if (networkResponse.errorText.isEmpty) {
      // String? myToken = await FirebaseMessaging.instance.getToken();
      // debugPrint("MyToken: $myToken  -------");
      // StorageRepository.setString(key: "fc_token", value: myToken ?? "");
      UserCredential userCredential = networkResponse.data as UserCredential;
      UserModel userModel =
      event.userModel.copyWith(authUid: userCredential.user!.uid);
      emit(
        state.copyWith(
          status: FormsStatus.authenticated,
          statusMessage: "registered",
          userModel: userModel,
        ),
      );
    } else {
      debugPrint("ERROR REGISTER USER!!! ${networkResponse.errorCode}");
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _googleSignIn(SignInWithGoogleEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse = await authRepository.googleSignIn();
    if (networkResponse.errorText.isEmpty) {
      UserCredential userCredential = networkResponse.data;
      emit(
        state.copyWith(
          statusMessage: "registered",
          status: FormsStatus.authenticated,
          userModel: UserModel(
            authUid: userCredential.user!.uid,
            email: userCredential.user!.email ?? "",
            userId: "",
            username: userCredential.user!.displayName ?? "",
            password: '',
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: networkResponse.errorText,
        ),
      );
    }
  }

  _logOutUser(LogOutUserEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    await authRepository.logOutUser();
    emit(state.copyWith(status: FormsStatus.unauthenticated));
  }
}
