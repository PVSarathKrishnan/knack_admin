import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:knack_admin/Domain/infrastructure/course_repository.dart';
import 'package:knack_admin/Domain/model/course_model.dart';

part 'fetch_course_event.dart';
part 'fetch_course_state.dart';

class FetchCourseBloc extends Bloc<FetchCourseEvent, FetchCourseState> {
  CourseRepo courseRepo = CourseRepo();
  FetchCourseBloc(this.courseRepo) : super(FetchCourseInitial()) {
    on<FetchCourseEvent>(getCoursesfunction);
  }

  FutureOr<void> getCoursesfunction(
      FetchCourseEvent event, Emitter<FetchCourseState> emit) async {
    emit(FetchCourseInitial());
    print("loading...................");
    final courses = await courseRepo.getCourses();
    print(courses);
    print("after loading");
    if (courses.isEmpty) {
      emit(FetchCourseInitial());
      print("empty");
    }
    emit(FetchCourseLoadedState(courseList: courses));
    print("loaded");
  }
}
