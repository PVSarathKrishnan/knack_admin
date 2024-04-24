part of 'fetch_course_bloc.dart';

sealed class FetchCourseEvent extends Equatable {
  const FetchCourseEvent();

  @override
  List<Object> get props => [];
}
class FetchCourseLoadedEvent extends FetchCourseEvent{
  
}