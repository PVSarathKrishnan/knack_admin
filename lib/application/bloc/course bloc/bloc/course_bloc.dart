import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitial()) {
    on<AddCourseEvent>(addCourseToFirebase);
    on<EditCourseEvent>(editCourseToFirebase);
    on<DeleteCourseEvent>(deleteCourseToFirebase);
  }
  FutureOr<void> addCourseToFirebase(
    AddCourseEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(LoadingState()); // Emit LoadingState 

    try {
      print("Adding course data: ${event.data}"); // Log course data
      await FirebaseFirestore.instance
          .collection("courses")
          .doc(event.CourseId)
          .set(event.data)
          .then((_) => emit(CourseAdded())); // Emit success state
      print("Course added successfully!");
    } on FirebaseException catch (e) {
      emit(CourseError(message: e.message!)); // Emit error state
      print("add course exception: ${e.message}");
    }
  }

  FutureOr<void> editCourseToFirebase(
      EditCourseEvent event, Emitter<CourseState> emit) async {
    try {
      print(event.CourseId);
      await FirebaseFirestore.instance
          .collection("courses")
          .doc(event.CourseId)
          .update(event.data)
          .then((value) {
        debugPrint("edit course success");
      });
    } on FirebaseException catch (e) {
      debugPrint("editCourse ${e.message}");
    }
  }

  FutureOr<void> deleteCourseToFirebase(
      DeleteCourseEvent event, Emitter<CourseState> emit) async {
    try {
      print(event.CourseId);
      await FirebaseFirestore.instance
          .collection("courses")
          .doc(event.CourseId)
          .delete();
    } on FirebaseException catch (e) {
      debugPrint("editCourse ${e.message}");
    }
  }
}
