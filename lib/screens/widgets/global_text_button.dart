import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:flutter/material.dart';

import '../../utils/styles/app_text_styles.dart';

class GlobalTextButton extends StatelessWidget {
  const GlobalTextButton(
      {super.key,
      this.isLoading = false,
      required this.text,
      required this.color,
      required this.onTap});

  final String text;
  final Color color;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isLoading ? color.withOpacity(0.5) : color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.w),
          ),
        ),
        onPressed: isLoading ? () {} : onTap,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style:
                    AppTextStyle.sfProRoundedRegular.copyWith(fontSize: 18.w),
              ),
      ),
    );
  }
}
