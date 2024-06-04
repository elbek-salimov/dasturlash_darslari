class LessonModel {
  final String lessonTitle;
  final String lessonVideoId;
  final String lessonDescription;
  final List<String> lessonImages;

  LessonModel({
    required this.lessonTitle,
    required this.lessonVideoId,
    required this.lessonDescription,
    required this.lessonImages,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
        lessonTitle: json['lesson_title'] as String? ?? '',
        lessonVideoId: json['lesson_videoId'] as String? ?? '',
        lessonDescription: json['lesson_description'] as String? ?? '',
        lessonImages: (json['lesson_images'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
      );

  static List<LessonModel> initialValue() => [
        LessonModel(
          lessonTitle: '',
          lessonVideoId: '',
          lessonDescription: '',
          lessonImages: [],
        ),
      ];
}
