import 'package:dasturlash_darslari/data/blocs/course/course_event.dart';
import 'package:dasturlash_darslari/data/blocs/course/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/forms_status.dart';
import '../../models/network_response.dart';
import '../../repository/course/course_repository.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc({required this.courseRepository})
      : super(CourseState.initialValue()) {
    on<GetCourseEvent>(_getCourse);
  }

  final CourseRepository courseRepository;

  _getCourse(GetCourseEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse networkResponse = await courseRepository.getCourses();
    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
        status: FormsStatus.success,
        courses: networkResponse.data,
      ));
    } else {
      emit(state.copyWith(
        status: FormsStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }
}
