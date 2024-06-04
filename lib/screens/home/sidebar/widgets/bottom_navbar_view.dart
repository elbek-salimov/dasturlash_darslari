import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../../data/models/sidebar_model.dart';
import '../../../../data/repository/sidebar_repository.dart';
import '../../../../utils/rive/rive_utils.dart';
import '../../../../utils/size/app_size.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key, required this.selectedNav});
  final int selectedNav;

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {

  int selectedNav = 0;
  List<SMIBool?> riveAnimates = List<SMIBool?>.filled(4, null, growable: false);

  @override
  void initState() {
    super.initState();
    selectedNav = widget.selectedNav;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF17203A).withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF17203A).withOpacity(0.3),
              offset: const Offset(0, 20),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(
              SideBarRepository().mainMenu.length,
                  (index) {
                SideBarModel sideMenu = SideBarRepository().mainMenu[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      RiveUtils.changeSMIBoolState(
                          riveAnimates[index]!);
                      selectedNav = index;
                    });

                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        margin: EdgeInsets.only(bottom: 2.h),
                        duration: const Duration(milliseconds: 200),
                        height: 4.h,
                        width: selectedNav == index ? 20 : 0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF81B4FF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 36.w,
                        width: 36.w,
                        child: Opacity(
                          opacity: selectedNav == index ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            'assets/RiveAssets/icons.riv',
                            artboard: sideMenu.artBoard,
                            onInit: (artBoard) {
                              riveAnimates[index] = RiveUtils.getRiveInput(
                                  artBoard,
                                  stateMachineName: sideMenu.stateMachineName);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
