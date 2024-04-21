part of 'course_bloc.dart';

sealed class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

class CourseInitial extends CourseState {}

class LoadingState extends CourseState {}

class CourseAdded extends CourseState {}

class CourseError extends CourseState {
  final String message;

  const CourseError({required this.message});
}
