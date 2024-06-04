import 'package:cached_network_image/cached_network_image.dart';
import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/models/course/course_model.dart';
import '../../../utils/styles/app_text_styles.dart';

class SearchCourseItems extends StatelessWidget {
  const SearchCourseItems(
      {super.key, required this.coursesForSearch, required this.onTap});

  final List<CourseModel> coursesForSearch;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: coursesForSearch.length,
      itemBuilder: (context, index) {
        final course = coursesForSearch[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
          child: GestureDetector(
            onTap: onTap,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100.h,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: course.courseImageUrl.isNotEmpty
                          ? course.courseImageUrl
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
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 14.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.courseTitle,
                        style: AppTextStyle.sfProRoundedMedium
                            .copyWith(fontSize: 26.w),
                      ),
                      Text(
                        '${course.courseLessonCount} Lessons',
                        style: AppTextStyle.sfProRoundedRegular
                            .copyWith(fontSize: 14.w),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
