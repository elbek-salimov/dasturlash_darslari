import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideBarTile extends StatelessWidget {
  const SideBarTile(
      {super.key,
      required this.onTap,
      required this.artBoard,
      required this.onInit,
      required this.selectedTile,
      required this.title});

  final VoidCallback onTap;
  final String artBoard;
  final OnInitCallback onInit;
  final bool selectedTile;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Divider(
            color: Colors.white24,
            height: 2.h,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              width: selectedTile ? 288.w : 0,
              height: 56,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6792FF),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: onTap,
              leading: SizedBox(
                height: 34.w,
                width: 34.w,
                child: RiveAnimation.asset(
                  'assets/RiveAssets/icons.riv',
                  artboard: artBoard,
                  onInit: onInit,
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
