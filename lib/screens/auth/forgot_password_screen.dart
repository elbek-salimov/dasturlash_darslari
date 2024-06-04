import 'package:dasturlash_darslari/screens/auth/widgets/textfield_view.dart';
import 'package:dasturlash_darslari/screens/widgets/global_text_button.dart';
import 'package:dasturlash_darslari/utils/colors/app_colors.dart';
import 'package:dasturlash_darslari/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/size/app_size.dart';
import '../../utils/styles/app_text_styles.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.cD4E0E8,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Column(
            children: [
              Image.asset(AppImages.lock),
              Text(
                'Forgot Password',
                style: AppTextStyle.sfProRoundedMedium
                    .copyWith(color: Colors.black, fontSize: 20.w),
              ),
              26.getH(),
              Text(
                'Provide your email and we will send you a link to reset your password',
                style: AppTextStyle.sfProRoundedRegular
                    .copyWith(color: Colors.black),
              ),
              20.getH(),
              Form(
                key: _formKey,
                child: TextFieldView(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter email';
                    }
                    if (!AppConstants.emailRegExp.hasMatch(value) ||
                        value.length < 3) {
                      return 'Incorrect email';
                    }
                    return null;
                  },
                  controller: emailController,
                  focusNode: focusNode,
                  onChanged: (v) {},
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              30.getH(),
              GlobalTextButton(
                text: 'Reset',
                color: AppColors.c97C93F,
                onTap: () {
                  focusNode.unfocus();
                  final isValidate = _formKey.currentState!.validate();
                  if (isValidate) {
                    // TODO password reset logic
                  }
                },
              ),
              10.getH(),
              TextButton(
                onPressed: () {
                  focusNode.unfocus();
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
    );
  }
}
