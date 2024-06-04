import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/images/app_images.dart';
import '../../../utils/styles/app_text_styles.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white38,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 1.w),
            borderRadius: BorderRadius.circular(14.w),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.google, height: 25.h),
            10.getW(),
            Text(
              'Google',
              style: AppTextStyle.sfProRoundedRegular.copyWith(fontSize: 18.w),
            ),
          ],
        ),
      ),
    );
  }
}
