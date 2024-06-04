import 'package:dasturlash_darslari/data/models/course/module_model.dart';
import 'package:dasturlash_darslari/screens/routes.dart';
import 'package:dasturlash_darslari/utils/colors/app_colors.dart';
import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:dasturlash_darslari/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/blocs/course/course_bloc.dart';
import '../../../data/blocs/course/course_state.dart';

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({super.key, required this.activeIndex});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cD4E0E8,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.cD4E0E8,
        centerTitle: true,
        title: Text(
          'Modullar',
          style:
              AppTextStyle.sfProRoundedSemiBold.copyWith(color: Colors.black),
        ),
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          List<ModuleModel> sortedModules = state.courses[activeIndex].modules;
          sortedModules.sort((a, b) => int.parse(a.moduleId.toString())
              .compareTo(int.parse(b.moduleId.toString())));
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.courses[activeIndex].modules.length,
            itemBuilder: (context, index) {
              ModuleModel moduleModel = sortedModules[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.w),
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
                      borderRadius: BorderRadius.circular(30.w),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.lesson,
                          arguments: {
                            'selectedModule': moduleModel,
                            'selectedCourse': state.courses[activeIndex],
                          });
                    },
                    leading: Text(
                      '${moduleModel.moduleId}',
                      style: AppTextStyle.sfProRoundedBold
                          .copyWith(color: Colors.black),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    title: Text(
                      moduleModel.moduleTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.sfProRoundedSemiBold
                          .copyWith(color: Colors.black, fontSize: 14.w),
                    ),
                    subtitle: Text(
                      'Darslar soni: ${moduleModel.lessons.length}',
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
