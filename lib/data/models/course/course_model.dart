import 'module_model.dart';

class CourseModel {
  final String courseTitle;
  final String courseImageUrl;
  final int courseLessonCount;
  final String courseCreatedAt;
  final String courseId;
  final bool isPopular;
  final bool isPaid;
  final double coursePrice;
  final int courseDuration;
  final String mentorName;
  final String mentorImageUrl;
  final List<ModuleModel> modules;

  CourseModel({
    required this.courseTitle,
    required this.courseImageUrl,
    required this.courseLessonCount,
    required this.courseCreatedAt,
    required this.courseId,
    required this.isPopular,
    required this.isPaid,
    required this.coursePrice,
    required this.courseDuration,
    required this.mentorName,
    required this.mentorImageUrl,
    required this.modules,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    courseTitle: json['course_title'] as String? ?? '',
    courseImageUrl: json['course_imageUrl'] as String? ?? '',
    courseLessonCount: json['course_lessonCount'] as int? ?? 0,
    courseCreatedAt: json['course_createdAt'] as String? ?? '',
    courseId: json['course_id'] as String? ?? '',
    isPopular: json['isPopular'] as bool? ?? false,
    isPaid: json['isPaid'] as bool? ?? true,
    coursePrice: (json['course_price'] as num?)?.toDouble() ?? 0.0,
    courseDuration: json['course_duration'] as int? ?? 0,
    mentorName: json['mentor_name'] as String? ?? '',
    mentorImageUrl: json['mentor_imageUrl'] as String? ?? '',
    modules: (json['modules'] as List<dynamic>?)
        ?.map((module) => ModuleModel.fromJson(module))
        .toList() ??
        [],
  );

  static List<CourseModel> initialValue() => [
    CourseModel(
      courseTitle: '',
      courseImageUrl: '',
      courseLessonCount: 0,
      courseCreatedAt: '',
      courseId: '',
      isPopular: false,
      isPaid: true,
      coursePrice: 0.0,
      courseDuration: 0,
      mentorName: '',
      mentorImageUrl: '',
      modules: ModuleModel.initialValue(),
    ),
  ];
}
