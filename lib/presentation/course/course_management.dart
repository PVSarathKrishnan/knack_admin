import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knack_admin/application/bloc/course%20bloc/bloc/course_bloc.dart';
import 'package:knack_admin/application/bloc/cover%20image%20bloc/bloc/cover_image_bloc.dart';
import 'package:knack_admin/application/bloc/fetch%20course%20bloc/bloc/fetch_course_bloc.dart';
import 'package:knack_admin/presentation/Custom%20Widgets/loader.dart';
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
      backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<FetchCourseBloc, FetchCourseState>(
            builder: (context, state) {
              if (state is FetchCourseLoadedState) {
                return Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: DataTable(
                      headingRowHeight: 50,
                      headingRowColor:
                          MaterialStatePropertyAll(Colors.grey[400]),
                      dataRowHeight: 80,
                      columns: [
                        DataColumn(
                            label: Text(
                          'Sl.No',
                          style: t1,
                        )),
                        DataColumn(label: Text('Title', style: t1)),
                        DataColumn(label: Text('OverView', style: t1)),
                        DataColumn(label: Text('Amount', style: t1)),
                        DataColumn(label: Text('Action', style: t1)),
                      ],
                      rows: [
                        for (int i = 0; i < state.courseList.length; i++)
                          DataRow(cells: [
                            DataCell(Text(
                              "${i + 1}",
                              style: t1.copyWith(fontSize: 15),
                            )),
                            DataCell(Text(
                              state.courseList[i].title,
                              style: t1.copyWith(fontSize: 15),
                            )),
                            DataCell(Text(
                              "${state.courseList[i].overview}",
                              style: t1.copyWith(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            )),
                            DataCell(Text(
                              int.parse(state.courseList[i].amount) > 0
                                  ? state.courseList[i].amount
                                  : "Free",
                              style: t1.copyWith(fontSize: 15),
                            )),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      deleteDialog(context,
                                          state.courseList[i].courseID);
                                    },
                                    icon: const Icon(Icons.delete_outline)),
                                IconButton(
                                    onPressed: () {
                                      showEditBox(context, state, i);
                                    },
                                    icon: const Icon(Icons.edit)),
                              ],
                            )),
                          ]),
                      ],
                    ),
                  ),
                );
              } else if (state is FetchCourseInitial) {
                return CustomLoaderWidget();
              }
              return Center(
                  child: Text(
                "Add courses to be listed",
                style: t1,
              ));
            },
          ),
        ),
      ),
    );
  }

  //edit box
  Future<void> showEditBox(
      BuildContext context, FetchCourseLoadedState state, int i) {
    double screenWidth = MediaQuery.of(context).size.width;
    _titleController.text = state.courseList[i].title;
    _overviewController.text = state.courseList[i].overview;
    _amountController.text = state.courseList[i].amount;
   

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Course"),
          content: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Container(
                    width: screenWidth / 3,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text("Title"),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _titleController,
                            validator: validateNotEmpty,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("OverView"),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _overviewController,
                            validator: validateNotEmpty,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Amount"),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _amountController,
                            validator: validateNotEmpty,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                         
                         
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                editCourse(
                                    context, state.courseList[i].courseID);
                              },
                              child: const Text("Edit Package"))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

//delete confirmation
  Future<void> deleteDialog(BuildContext context, String id) async {
    print("called delete dialog");
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
                context
                    .read<CourseBloc>()
                    .add((DeleteCourseEvent(CourseId: id)));
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
    if (_key.currentState!.validate() ) {
      firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance
          .ref("course_${_titleController.text.trim()}");
      firebasestorage.UploadTask uploadTask = ref.putData(newImage!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Uploading data !"),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 5),
      ));
      await uploadTask;

      var downloadUrl = await ref.getDownloadURL();

      Map<String, String> data = {
        "SubsId": courseID,
        "photo": downloadUrl,
        "title": _titleController.text.trim(),
        "overview": _overviewController.text.trim(),
        "amount": _amountController.text.trim()
      };
      context
          .read<CourseBloc>()
          .add(EditCourseEvent(data: data, CourseId: courseID));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Subscription added successfully !"),
        backgroundColor: Colors.green,
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
