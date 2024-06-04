import 'package:dasturlash_darslari/screens/routes.dart';
import 'package:dasturlash_darslari/screens/widgets/global_text_button.dart';
import 'package:dasturlash_darslari/utils/colors/app_colors.dart';
import 'package:dasturlash_darslari/utils/images/app_images.dart';
import 'package:dasturlash_darslari/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../utils/size/app_size.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.cD4E0E8,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.getH(),
              Image.asset(AppImages.programmingLanguages, height: 350.h),
              Padding(
                padding: EdgeInsets.only(left: 32.w, right: 32.w),
                child: Column(
                  children: [
                    Text(
                      'Achieve all your goals now',
                      style: AppTextStyle.sfProRoundedSemiBold
                          .copyWith(fontSize: 35.w, color: Colors.black54),
                    ),
                    30.getH(),
                    Text(
                      'Online courses to specialize in the professions that lead the market today.',
                      style: AppTextStyle.sfProRoundedRegular
                          .copyWith(color: Colors.black54),
                    ),
                    30.getH(),
                    GlobalTextButton(
                      text: 'Log in',
                      color: AppColors.c97C93F,
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.login);
                      },
                    ),
                    20.getH(),
                    GlobalTextButton(
                      text: 'Create account',
                      color: AppColors.c439FF8,
                      onTap: (){
                        Navigator.pushNamed(context, RouteNames.signup);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
