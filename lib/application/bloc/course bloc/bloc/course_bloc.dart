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
      AddCourseEvent event, Emitter<CourseState> emit) async {
    try {
      await FirebaseFirestore.instance
          .collection("courses")
          .doc(event.CourseId)
          .set(event.data)
          .then((value) {
        debugPrint("add course success");
      });
    } on FirebaseException catch (e) {
      debugPrint("add course ${e.message}");
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
