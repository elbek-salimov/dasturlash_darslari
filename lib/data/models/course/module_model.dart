import 'lesson_model.dart';

class ModuleModel {
  final String moduleTitle;
  final int moduleId;
  final String moduleUid;
  final List<LessonModel> lessons;

  ModuleModel({
    required this.moduleTitle,
    required this.moduleId,
    required this.moduleUid,
    required this.lessons,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) => ModuleModel(
    moduleTitle: json['module_title'] as String? ?? '',
    moduleId: json['module_id'] as int? ?? 0,
    moduleUid: json['module_uid'] as String? ?? '',
    lessons: (json['lessons'] as List<dynamic>?)
        ?.map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],
  );

  static List<ModuleModel> initialValue() => [
    ModuleModel(
      moduleTitle: '',
      moduleId: 0,
      moduleUid: '',
      lessons: LessonModel.initialValue(),
    ),
  ];
}