// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'course_bloc.dart';

sealed class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class CourseInitialEvent extends CourseEvent {}

class AddCourseEvent extends CourseEvent {
  Map<String, dynamic> data = {};
  String CourseId;
  AddCourseEvent({
    required this.data,
    required this.CourseId,
  });
}

class EditCourseEvent extends CourseEvent {
  Map<String, dynamic> data = {};
  String CourseId;
  EditCourseEvent({
    required this.data,
    required this.CourseId,
  });
}

class DeleteCourseEvent extends CourseEvent {
  String CourseId;
  DeleteCourseEvent({
    required this.CourseId,
  });
}
