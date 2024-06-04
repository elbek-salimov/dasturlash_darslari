import 'dart:ui';
import 'package:dasturlash_darslari/data/models/forms_status.dart';
import 'package:dasturlash_darslari/data/models/user/user_model.dart';
import 'package:dasturlash_darslari/screens/auth/widgets/google_signin_button.dart';
import 'package:dasturlash_darslari/screens/routes.dart';
import 'package:dasturlash_darslari/screens/widgets/global_text_button.dart';
import 'package:dasturlash_darslari/screens/auth/widgets/textfield_view.dart';
import 'package:dasturlash_darslari/utils/colors/app_colors.dart';
import 'package:dasturlash_darslari/utils/constants/app_constants.dart';
import 'package:dasturlash_darslari/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../data/blocs/auth/auth_bloc.dart';
import '../../utils/size/app_size.dart';
import 'dialogs/loading_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  double containerHeight = 0;

  bool obscureText = true;

  _init() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        containerHeight = height / 1.25;
      });
    });
  }

  @override
  void initState() {
    _init();
    emailFocusNode.addListener(emailFocus);
    nameFocusNode.addListener(nameFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    controller?.dispose();
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void nameFocus() {
    isChecking?.change(nameFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.cD4E0E8,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state.status == FormsStatus.error) {
            showLoadingDialog(context, state.errorMessage);
            await Future.delayed(const Duration(milliseconds: 1500));
            if (!context.mounted) return;
            Navigator.pop(context);
            trigFail?.change(true);
          }
          if (state.status == FormsStatus.authenticated) {
            trigSuccess?.change(true);
            showLoadingDialog(context, 'Success');
            await Future.delayed(const Duration(milliseconds: 1500));
            if (!context.mounted) return;
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.sideBar, (route) => false);
          }
        },
        child: GestureDetector(
          onTap: () {
            emailFocusNode.unfocus();
            nameFocusNode.unfocus();
            passwordFocusNode.unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 180.h,
                      child: RiveAnimation.asset(
                        'assets/RiveAssets/animated_login_character.riv',
                        stateMachines: const ["Login Machine"],
                        onInit: (artBoard) {
                          controller = StateMachineController.fromArtboard(
                            artBoard,
                            "Login Machine",
                          );
                          if (controller == null) return;

                          artBoard.addController(controller!);
                          isChecking = controller?.findInput("isChecking");
                          numLook = controller?.findInput("numLook");
                          isHandsUp = controller?.findInput("isHandsUp");
                          trigSuccess = controller?.findInput("trigSuccess");
                          trigFail = controller?.findInput("trigFail");
                        },
                      ),
                    ),
                    200.getH(),
                    Transform.rotate(
                      angle: 6.8,
                      child: Text(
                        'Elbek Salimov',
                        style: AppTextStyle.sfProRoundedThin
                            .copyWith(fontSize: 50.w),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      height: containerHeight,
                      width: width,
                      padding: EdgeInsets.only(left: 35.w, right: 35.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.w),
                          topRight: Radius.circular(30.w),
                        ),
                        color: Colors.blueAccent.shade200.withOpacity(0.1),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              20.getH(),
                              Text(
                                'Get Started Free',
                                style: AppTextStyle.sfProRoundedSemiBold
                                    .copyWith(
                                        fontSize: 40.w, color: Colors.black54),
                              ),
                              Text(
                                'Free Forever. No Credit Card Needed',
                                style: AppTextStyle.sfProRoundedMedium.copyWith(
                                    fontSize: 14.w, color: Colors.grey),
                              ),
                              10.getH(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email Address',
                                  style: AppTextStyle.sfProRoundedMedium
                                      .copyWith(
                                          fontSize: 14.w,
                                          color: Colors.black54),
                                ),
                              ),
                              6.getH(),
                              TextFieldView(
                                hintText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                controller: emailController,
                                focusNode: emailFocusNode,
                                onChanged: (value) {
                                  numLook?.change(value.length.toDouble());
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter email';
                                  }
                                  if (!AppConstants.emailRegExp
                                          .hasMatch(value) ||
                                      value.length < 3) {
                                    return 'Incorrect email';
                                  }
                                  return null;
                                },
                              ),
                              15.getH(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Your Name',
                                  style: AppTextStyle.sfProRoundedMedium
                                      .copyWith(
                                          fontSize: 14.w,
                                          color: Colors.black54),
                                ),
                              ),
                              6.getH(),
                              TextFieldView(
                                hintText: 'Name',
                                prefixIcon: const Icon(Icons.person_outline),
                                controller: nameController,
                                focusNode: nameFocusNode,
                                onChanged: (value) {
                                  numLook?.change(value.length.toDouble());
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter name';
                                  }
                                  if (!AppConstants.textRegExp
                                          .hasMatch(value) ||
                                      value.length < 3) {
                                    return 'Incorrect name';
                                  }
                                  return null;
                                },
                              ),
                              15.getH(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Password',
                                  style: AppTextStyle.sfProRoundedMedium
                                      .copyWith(
                                          fontSize: 14.w,
                                          color: Colors.black54),
                                ),
                              ),
                              6.getH(),
                              TextFieldView(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    obscureText
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                ),
                                obscureText: true,
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                controller: passwordController,
                                focusNode: passwordFocusNode,
                                onChanged: (value) {
                                  if (isChecking != null) {
                                    isChecking!.change(false);
                                  }
                                  if (isHandsUp == null) return;

                                  isHandsUp!.change(true);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter password';
                                  }
                                  if (!AppConstants.passwordRegExp
                                      .hasMatch(value)) {
                                    return 'Incorrect password';
                                  }
                                  return null;
                                },
                              ),
                              24.getH(),
                              GlobalTextButton(
                                text: 'Sign in',
                                color: AppColors.c97C93F,
                                onTap: () {
                                  emailFocusNode.unfocus();
                                  nameFocusNode.unfocus();
                                  passwordFocusNode.unfocus();

                                  final isValidate =
                                      _formKey.currentState!.validate();
                                  if (isValidate) {
                                    context.read<AuthBloc>().add(
                                          RegisterUserEvent(
                                            userModel: UserModel(
                                              email: emailController.text,
                                              userId: '',
                                              username: nameController.text,
                                              authUid: '',
                                              password: passwordController.text,
                                            ),
                                          ),
                                        );
                                  } else {
                                    trigFail?.change(true);
                                  }
                                },
                              ),
                              18.getH(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      height: 1.h,
                                      thickness: 1.h,
                                      indent: 10,
                                      endIndent: 20,
                                    ),
                                  ),
                                  Text(
                                    'Or continue with',
                                    style: AppTextStyle.sfProRoundedLight
                                        .copyWith(color: Colors.black54),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      height: 1.h,
                                      thickness: 1.h,
                                      indent: 10,
                                      endIndent: 20,
                                    ),
                                  ),
                                ],
                              ),
                              18.getH(),
                              GoogleSignInButton(
                                onTap: () {
                                  context.read<AuthBloc>().add(
                                        SignInWithGoogleEvent(),
                                      );
                                },
                              ),
                              15.getH(),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Go Back',
                                  style: AppTextStyle.sfProRoundedSemiBold
                                      .copyWith(fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
