import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knack_admin/Domain/model/course_model.dart';
import 'package:knack_admin/application/bloc/course%20bloc/bloc/course_bloc.dart';
import 'package:knack_admin/application/bloc/cover%20image%20bloc/bloc/cover_image_bloc.dart';
import 'package:knack_admin/application/bloc/fetch%20course%20bloc/bloc/fetch_course_bloc.dart';
import 'package:knack_admin/presentation/Custom%20Widgets/loader.dart';
import 'package:knack_admin/presentation/course/course_view.dart';
import 'package:knack_admin/presentation/style/text_style.dart';

class CourseManagementScreen extends StatefulWidget {
  CourseManagementScreen({super.key});

  @override
  State<CourseManagementScreen> createState() => _CourseManagementScreenState();
}

class _CourseManagementScreenState extends State<CourseManagementScreen> {
  final _key = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _overviewController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  Uint8List? newImage;
  String? subId;

  @override
  Widget build(BuildContext context) {
    context.read<FetchCourseBloc>().add(FetchCourseLoadedEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Course Lists",
          style: t1,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<FetchCourseBloc, FetchCourseState>(
          builder: (context, state) {
            if (state is FetchCourseLoadedState) {
              return ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: state.courseList.length,
                itemBuilder: (context, index) {
                  return CourseTile(course: state.courseList[index]);
                },
              );
            } else if (state is FetchCourseInitial) {
              return CustomLoaderWidget();
            }
            return Center(
              child: Text(
                "Add courses to be listed",
                style: t1,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> deleteDialog(BuildContext context, String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Course?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This Course will be removed and cannot be revoked.'),
                Text('Would you like to continue?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                context.read<CourseBloc>().add(DeleteCourseEvent(CourseId: id));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Removing Subscription..."),
                  backgroundColor: Colors.blue,
                ));
                Future.delayed(Duration(seconds: 3)).then((value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Subscription removed"),
                    backgroundColor: Colors.blue,
                  ));
                });
              },
            ),
          ],
        );
      },
    );
  }

  void editCourse(BuildContext context, String courseID) async {
    if (_key.currentState!.validate()) {
      firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance
          .ref("course_${_titleController.text.trim()}");
      firebasestorage.UploadTask uploadTask = ref.putData(newImage!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Uploading data !"),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 5),
      ));

      Map<String, String> data = {
        "SubsId": courseID,
        "title": _titleController.text.trim(),
        "overview": _overviewController.text.trim(),
        "amount": _amountController.text.trim()
      };
      context
          .read<CourseBloc>()
          .add(EditCourseEvent(data: data, CourseId: courseID));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Subscription added successfully !"),
        backgroundColor: Color(0xFF2E2E48),
      ));
      Navigator.pop(context);
      _titleController.clear();
      _overviewController.clear();
      _amountController.clear();
      context.read<CoverImageBloc>().add(ImagePickerInitial());
    } else {
      debugPrint("form not validated");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something unexpected happened!"),
        backgroundColor: Colors.red,
      ));
    }
  }

  //to validate not empty
  String? validateNotEmpty(String? value) {
    final trimmedValue = value?.trim();

    if (trimmedValue == null || trimmedValue.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }
}

class CourseTile extends StatelessWidget {
  final CourseModel course;

  CourseTile({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          course.title,
          style: t1.copyWith(fontSize: 20),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overview: ${course.overview}",
              style: t1.copyWith(fontSize: 15),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5),
            Text(
              "Amount: ${int.parse(course.amount) > 0 ? course.amount : "Free"}",
              style: t1.copyWith(fontSize: 15),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CourseViewScreen(course: course),
                ));
              },
              icon: const Icon(Icons.remove_red_eye_outlined),
            ),
            IconButton(
              onPressed: () {
                deleteDialog(context, course.courseID);
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
            // Uncomment if edit functionality is needed
            // IconButton(
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => AddCourseScreen(
            //         isEditing: true,
            //         courseModel: course,
            //       ),
            //     ));
            //   },
            //   icon: const Icon(Icons.edit),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteDialog(BuildContext context, String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Course?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This Course will be removed and cannot be revoked.'),
                Text('Would you like to continue?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                context.read<CourseBloc>().add(DeleteCourseEvent(CourseId: id));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Removing Subscription..."),
                  backgroundColor: Colors.blue,
                ));
                Future.delayed(Duration(seconds: 3)).then((value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Subscription removed"),
                    backgroundColor: Colors.blue,
                  ));
                });
              },
            ),
          ],
        );
      },
    );
  }
}
