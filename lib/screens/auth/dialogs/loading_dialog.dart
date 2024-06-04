import 'package:dasturlash_darslari/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../utils/size/app_size.dart';

void showLoadingDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return PopScope(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 50.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                20.getH(),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.sfProRoundedMedium
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
