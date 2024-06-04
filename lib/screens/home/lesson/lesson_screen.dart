import 'package:cached_network_image/cached_network_image.dart';
import 'package:dasturlash_darslari/data/models/course/lesson_model.dart';
import 'package:dasturlash_darslari/data/models/course/module_model.dart';
import 'package:dasturlash_darslari/screens/routes.dart';
import 'package:dasturlash_darslari/utils/colors/app_colors.dart';
import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:dasturlash_darslari/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/blocs/course/course_bloc.dart';
import '../../../data/blocs/course/course_state.dart';
import '../../../data/models/course/course_model.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({
    super.key,
    required this.selectedModule, required this.selectedCourse,
  });

  final ModuleModel selectedModule;
  final CourseModel selectedCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cD4E0E8,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.cD4E0E8,
        centerTitle: true,
        title: Text(
          'Darslar',
          style:
              AppTextStyle.sfProRoundedSemiBold.copyWith(color: Colors.black),
        ),
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: selectedModule.lessons.length,
            itemBuilder: (context, index) {
              LessonModel lessonModel = selectedModule.lessons[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.h,
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 5),
                      )
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.topic,
                        arguments: {
                          'selectedLesson': lessonModel,
                          'selectedCourse': selectedCourse,
                        },
                      );
                    },
                    leading: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.w),
                          child: CachedNetworkImage(
                            width: 70.w,
                            fit: BoxFit.cover,
                            imageUrl: lessonModel.lessonVideoId.isNotEmpty
                                ? 'https://img.youtube.com/vi/${lessonModel.lessonVideoId}/maxresdefault.jpg'
                                : 'https://www.sleepworld.com/on/demandware.static/Sites-Sleepworld-Site/-/default/dw5a35aafc/images/large_missing.jpg',
                            placeholder: (context, url) => Shimmer.fromColors(
                              enabled: true,
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(6.w),
                                ),
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ),
                        const Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Icon(Icons.play_circle_outline,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal,
                      ),
                      child:
                          const Icon(Icons.lock_outline, color: Colors.white),
                    ),
                    title: Text(
                      lessonModel.lessonTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.sfProRoundedSemiBold
                          .copyWith(color: Colors.black, fontSize: 14.w),
                    ),
                    subtitle: Text(
                      '02:24',
                      style: AppTextStyle.sfProRoundedSemiBold
                          .copyWith(color: Colors.black54, fontSize: 14.w),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
