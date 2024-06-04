part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckAuthenticationEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends AuthEvent {
  final String password;
  final String email;

  LoginUserEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
    email,
    password,
  ];
}

class RegisterUserEvent extends AuthEvent {
  final UserModel userModel;

  RegisterUserEvent({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class LogOutUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignInWithGoogleEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
