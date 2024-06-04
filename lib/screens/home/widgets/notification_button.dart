import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../utils/styles/app_text_styles.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton(
      {super.key,
      required this.onTap,
      required this.notificationCount,
      required this.onInit});

  final VoidCallback onTap;
  final int notificationCount;
  final OnInitCallback onInit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12.w, top: 5.h),
            padding: EdgeInsets.all(5.w),
            height: 40.w,
            width: 40.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.black87,
                BlendMode.srcATop,
              ),
              child: RiveAnimation.asset(
                'assets/RiveAssets/icons.riv',
                artboard: 'BELL',
                onInit: onInit,
              ),
            ),
          ),
          if (notificationCount != 0)
            Container(
              margin: EdgeInsets.only(top: 8.h, left: 10.w),
              height: 15.w,
              width: 15.w,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  notificationCount > 9 ? '9+' : '$notificationCount',
                  style:
                      AppTextStyle.sfProRoundedMedium.copyWith(fontSize: 10.w),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
