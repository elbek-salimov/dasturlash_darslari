import 'package:dasturlash_darslari/data/models/course/course_model.dart';
import 'package:dasturlash_darslari/screens/home/widgets/banner_items.dart';
import 'package:dasturlash_darslari/screens/home/widgets/course_items.dart';
import 'package:dasturlash_darslari/screens/home/widgets/notification_button.dart';
import 'package:dasturlash_darslari/screens/home/widgets/search_course_items.dart';
import 'package:dasturlash_darslari/screens/routes.dart';
import 'package:dasturlash_darslari/utils/colors/app_colors.dart';
import 'package:dasturlash_darslari/utils/formatters/app_formatters.dart';
import 'package:dasturlash_darslari/utils/images/app_images.dart';
import 'package:dasturlash_darslari/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

import '../../data/blocs/banner/banner_bloc.dart';
import '../../data/blocs/banner/banner_state.dart';
import '../../data/blocs/course/course_bloc.dart';
import '../../data/blocs/course/course_state.dart';
import '../../utils/rive/rive_utils.dart';
import '../../utils/size/app_size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = ['All', 'Popular', 'Newest'];

  int activeIndex = 0;

  int selectedCourseIndex = 0;

  SMIBool? notificationRive;

  TextEditingController controller = TextEditingController();

  List<CourseModel> coursesForSearch = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.cD4E0E8,
      appBar: AppBar(
        backgroundColor: AppColors.cD4E0E8,
        elevation: 0,
        title: Text(
          'Dasturlash darslari',
          style: AppTextStyle.sfProRoundedSemiBold
              .copyWith(color: Colors.black54, fontSize: 24.w),
        ),
        centerTitle: true,
        actions: [
          NotificationButton(
            onTap: () async {
              setState(() {
                RiveUtils.changeSMIBoolState(notificationRive!);
              });
              await Future.delayed(const Duration(milliseconds: 1000));
              if (!context.mounted) return;
              Navigator.pushNamed(context, RouteNames.notification);
            },
            notificationCount: 7,
            onInit: (artBoard) {
              notificationRive = RiveUtils.getRiveInput(artBoard,
                  stateMachineName: 'BELL_Interactivity');
            },
          ),
          12.getW()
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            List<CourseModel> courses;
            if (activeIndex == 1 && state.courses.isNotEmpty) {
              // Popular
              courses =
                  state.courses.where((course) => course.isPopular).toList();
            } else if (activeIndex == 2) {
              // Newest
              courses = List.from(state.courses)
                ..sort(
                    (a, b) => b.courseCreatedAt.compareTo(a.courseCreatedAt));
            } else {
              courses = state.courses;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.getH(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: TextField(
                    inputFormatters: [AppInputFormatters.text],
                    controller: controller,
                    onChanged: (value) {
                      setState(() {
                        coursesForSearch = state.courses
                            .where((course) => course.courseTitle
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white38,
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search your course...',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.w),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.w),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                15.getH(),
                controller.text.isEmpty
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              BlocBuilder<BannerBloc, BannerState>(
                                builder: (context, state) {
                                  return BannerItems(
                                    banners: state.banners,
                                  );
                                },
                              ),
                              20.getH(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Explore your course',
                                      style: AppTextStyle.sfProRoundedBold
                                          .copyWith(color: Colors.black),
                                    ),
                                    10.getH(),
                                    Row(
                                      children: [
                                        ...List.generate(
                                          categories.length,
                                          (index) => Row(
                                            children: [
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.w,
                                                      vertical: 5.h),
                                                  minimumSize: Size.zero,
                                                  backgroundColor:
                                                      activeIndex == index
                                                          ? AppColors.c439FF8
                                                          : Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.w),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    activeIndex = index;
                                                  });
                                                },
                                                child: Text(
                                                  categories[index],
                                                  style: AppTextStyle
                                                      .sfProRoundedSemiBold
                                                      .copyWith(
                                                          fontSize: 14.w,
                                                          color: activeIndex ==
                                                                  index
                                                              ? Colors.white
                                                              : Colors.grey),
                                                ),
                                              ),
                                              10.getW(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    10.getH(),
                                    CourseItems(
                                      selectedCourseIndex: selectedCourseIndex,
                                      courses: courses,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RouteNames.module,
                                            arguments: selectedCourseIndex);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: coursesForSearch.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 40.w,
                                    right: 40.w,
                                    bottom: height / 3),
                                child: Lottie.asset(AppImages.noData),
                              )
                            : SearchCourseItems(
                                coursesForSearch: coursesForSearch,
                                onTap: () {},
                              ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
