import 'dart:math';

import 'package:dasturlash_darslari/data/models/sidebar_model.dart';
import 'package:dasturlash_darslari/data/repository/sidebar_repository.dart';
import 'package:dasturlash_darslari/screens/home/home_screen.dart';
import 'package:dasturlash_darslari/screens/home/sidebar/widgets/sidebar_tile.dart';
import 'package:dasturlash_darslari/utils/rive/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../utils/size/app_size.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({super.key});

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  bool isSideBarOpen = false;
  late SMIBool isMenuOpenInput;

  List<SMIBool?> riveAnimatesBrowse =
      List<SMIBool?>.filled(4, null, growable: false);
  List<SMIBool?> riveAnimatesMore =
      List<SMIBool?>.filled(3, null, growable: false);
  SMIBool? menuRive;

  late AnimationController _animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF17203A),
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            width: 288.w,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 0 : -288.w,
            top: 0,
            child: Container(
              width: 288.w,
              height: double.infinity,
              color: const Color(0xFF17203A),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white24,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          'Elbek Salimov',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Developer',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 24, top: 32, bottom: 16),
                        child: Text(
                          "BROWSE",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                      ...List.generate(
                        SideBarRepository().mainMenu.length,
                        (index) {
                          SideBarModel sideMenu =
                              SideBarRepository().mainMenu[index];
                          return SideBarTile(
                            onTap: () {
                              setState(() {
                                RiveUtils.changeSMIBoolState(
                                    riveAnimatesBrowse[index]!);
                                activeIndex = index;
                              });
                            },
                            artBoard: sideMenu.artBoard,
                            onInit: (artBoard) {
                              riveAnimatesBrowse[index] = RiveUtils.getRiveInput(
                                  artBoard,
                                  stateMachineName: sideMenu.stateMachineName);
                            },
                            selectedTile: activeIndex == index,
                            title: sideMenu.title,
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 24, top: 32, bottom: 16),
                        child: Text(
                          "MORE",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                      ...List.generate(
                        SideBarRepository().moreMenu.length,
                        (index) {
                          SideBarModel sideMenu =
                              SideBarRepository().moreMenu[index];
                          return SideBarTile(
                            onTap: () {
                              setState(() {
                                RiveUtils.changeSMIBoolState(
                                    riveAnimatesMore[index]!);
                                activeIndex = index + 4;
                              });
                            },
                            artBoard: sideMenu.artBoard,
                            onInit: (artBoard) {
                              riveAnimatesMore[index] = RiveUtils.getRiveInput(
                                  artBoard,
                                  stateMachineName: sideMenu.stateMachineName);
                            },
                            selectedTile: activeIndex == index + 4,
                            title: sideMenu.title,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                  1 * animation.value - 30.w * (animation.value) * pi / 180.w),
            child: Transform.translate(
              offset: Offset(animation.value * 265.w, 0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(isSideBarOpen ? 25 : 0),
                  ),
                  child: AbsorbPointer(
                    absorbing: isSideBarOpen,
                    child: GestureDetector(
                      onTap: isSideBarOpen ? null : () {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      child: const HomeScreen(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 220.w : 0,
            top: 27.h,
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus!.unfocus();
                isMenuOpenInput.value = !isMenuOpenInput.value;

                if (_animationController.value == 0) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }

                setState(
                  () {
                    isSideBarOpen = !isSideBarOpen;
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 12.w),
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
                child: RiveAnimation.asset(
                  "assets/RiveAssets/menu_button.riv",
                  onInit: (artBoard) {
                    final controller = StateMachineController.fromArtboard(
                        artBoard, "State Machine");

                    artBoard.addController(controller!);

                    isMenuOpenInput =
                        controller.findInput<bool>("isOpen") as SMIBool;
                    isMenuOpenInput.value = true;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Transform.translate(
      //   offset: Offset(0, 100 * animation.value),
      //   child: BottomNavBarView(selectedNav: activeIndex),
      // ),
    );
  }
}
