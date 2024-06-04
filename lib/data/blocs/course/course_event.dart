import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class GetCourseEvent extends CourseEvent {
  @override
  List<Object?> get props => [];
}

