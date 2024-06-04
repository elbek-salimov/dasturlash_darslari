import 'package:dasturlash_darslari/data/models/course/course_model.dart';
import 'package:equatable/equatable.dart';

import '../../models/forms_status.dart';

class CourseState extends Equatable {
  final List<CourseModel> courses;
  final FormsStatus status;
  final String errorMessage;

  const CourseState({
    required this.courses,
    required this.status,
    required this.errorMessage,
  });

  CourseState copyWith({
    List<CourseModel>? courses,
    FormsStatus? status,
    String? errorMessage,
  }) {
    return CourseState(
      courses: courses ?? this.courses,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  static CourseState initialValue() => CourseState(
      courses: CourseModel.initialValue(),
      status: FormsStatus.pure,
      errorMessage: '');

  @override
  List<Object?> get props => [
    courses,
    status,
    errorMessage,
  ];
}
