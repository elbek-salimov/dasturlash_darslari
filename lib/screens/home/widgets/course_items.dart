import 'package:cached_network_image/cached_network_image.dart';
import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/models/course/course_model.dart';
import '../../../utils/styles/app_text_styles.dart';

class CourseItems extends StatelessWidget {
  const CourseItems(
      {super.key,
      required this.courses,
      required this.onTap,
      required this.selectedCourseIndex});

  final List<CourseModel> courses;
  final VoidCallback onTap;
  final int selectedCourseIndex;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.9,
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 20.h,
      children: [
        ...List.generate(
          courses.length,
          (index) {
            index = selectedCourseIndex;
            // NumberFormat
            final NumberFormat numberFormat = NumberFormat('#,##0', 'en_US');
            String formattedNumber =
                numberFormat.format(courses[index].coursePrice);

            return GestureDetector(
              onTap: onTap,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 100.h,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: courses[index].courseImageUrl.isNotEmpty
                            ? courses[index].courseImageUrl
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.getH(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            courses[index].courseTitle,
                            style: AppTextStyle.sfProRoundedSemiBold
                                .copyWith(fontSize: 14.w, color: Colors.black),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: courses[index].isPaid
                                  ? Colors.redAccent
                                  : Colors.greenAccent,
                              borderRadius: BorderRadius.circular(30.w),
                            ),
                            child: Text(
                                courses[index].isPaid ? 'Pullik' : 'Bepul',
                                style: AppTextStyle.sfProRoundedMedium),
                          ),
                        ],
                      ),
                      Text(
                        '${courses[index].courseLessonCount} ta dars',
                        style: AppTextStyle.sfProRoundedRegular
                            .copyWith(fontSize: 12.w, color: Colors.black54),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Narxi:',
                            style: AppTextStyle.sfProRoundedMedium
                                .copyWith(fontSize: 12.w, color: Colors.black),
                          ),
                          SizedBox(
                            width: width / 4,
                            child: Text(
                              '$formattedNumber UZS',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.end,
                              style: AppTextStyle.sfProRoundedRegular.copyWith(
                                  fontSize: 12.w,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
