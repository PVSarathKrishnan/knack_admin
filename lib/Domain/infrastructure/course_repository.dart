import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knack_admin/Domain/model/course_model.dart';

class CourseRepo {
  Future<List<CourseModel>> getCourses() async {
    List<CourseModel> courseList = [];

    try {
      print('course repo try  1');
      final datas =
          await FirebaseFirestore.instance.collection("courses").get();
      datas.docs.forEach((element) {
        final data = element.data();
        print('course repo try  2');
        final course = CourseModel(
            courseID: data["courseID"],
            photo: data["photo"],
            title: data["title"],
            overview: data["overview"],
            chapters: data["chapters"],
            description: data["description"],
            amount: data["amount"],
            document: data["document"],
            videos: data["videos"]
            );
        print('course repo try  3');
        courseList.add(course);
        print('course repo try  4');
        print(course);
      });
      return courseList;
    } on FirebaseException catch (e) {
      debugPrint("exception on fetching subscriptions :${e.message}");
    }
    return courseList;
  }
}
