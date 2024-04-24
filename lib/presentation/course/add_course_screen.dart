import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knack_admin/application/bloc/course%20bloc/bloc/course_bloc.dart';
import 'package:knack_admin/application/bloc/cover%20image%20bloc/bloc/cover_image_bloc.dart';
import 'package:knack_admin/presentation/style/text_style.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _key = GlobalKey<FormState>();
  FilePickerResult? _pickedFile;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _overViewController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _chapterNameController = TextEditingController();
  List<TextEditingController> chapterController = [TextEditingController()];
  TextEditingController _descriptionNameController = TextEditingController();
  List<TextEditingController> descriptionController = [TextEditingController()];
  TextEditingController _linkNameController = TextEditingController();
  List<TextEditingController> linkController = [TextEditingController()];
  String? courseID;
  String? coverImage;
  Uint8List? newImage;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String fileName = _pickedFile?.files.first.name ?? '';
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          child: Column(
            children: [
              Text(
                "Add a new Course",
                style: t1.copyWith(fontSize: 28, color: Colors.green),
              ),
              Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Title",
                      style: t1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _titleController,
                      validator: nonEmptyValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2)),
                          disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2)),
                          border: OutlineInputBorder(
                              gapPadding: 12,
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2))),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "overview",
                      style: t1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 5,
                      controller: _overViewController,
                      validator: nonEmptyValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2)),
                          disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2)),
                          border: OutlineInputBorder(
                              gapPadding: 12,
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2))),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Pick cover image",
                              style: t1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<CoverImageBloc, CoverImageState>(
                              builder: (context, state) {
                                if (state is ImageUpdateState) {
                                  return GestureDetector(
                                    onTap: () {
                                       newImage = state.imageFile;
                                      context
                                          .read<CoverImageBloc>()
                                          .add(ImageUpdateEvent());
                                     
                                    },
                                    child: Center(
                                      child: Container(
                                        height: 200,
                                        width: screenWidth / 4,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        child: Image.memory(
                                          state.imageFile,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CoverImageBloc>()
                                        .add(ImageUpdateEvent());
                                        
                                  },
                                  child: Center(
                                    child: Container(
                                        height: 200,
                                        width: screenWidth / 4,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        child: Icon(Icons.image)),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Select document",
                              style: t1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 200,
                              width: screenWidth / 4,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: InkWell(
                                onTap: _pickFile,
                                child: _pickedFile != null
                                    ? Center(
                                        child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "lib/assets/doc.png",
                                            height: 100,
                                            width: 100,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            fileName,
                                            style: t1.copyWith(fontSize: 15),
                                          ),
                                        ],
                                      ))
                                    : Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.cloud_upload,
                                              size: 70,
                                            ),
                                            Text(
                                              "Click here to select document",
                                              style: t1,
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Text(
                                                "Select only PDF and DOCX files for upload.")
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      shrinkWrap: true,
                      itemCount: linkController.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                border:
                                    Border.all(width: 2, color: Colors.grey)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Chapter ${index + 1} :",
                                        style: t1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: chapterController[index],
                                        validator: nonEmptyValidator,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                            hintText: "Heading",
                                            filled: true,
                                            fillColor: Colors.white,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2)),
                                            disabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2)),
                                            border: OutlineInputBorder(
                                                gapPadding: 12,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2))),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Description",
                                        style: t1,
                                      ),
                                      TextFormField(
                                        controller:
                                            descriptionController[index],
                                        validator: nonEmptyValidator,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                            hintText: "type here...",
                                            filled: true,
                                            fillColor: Colors.white,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2)),
                                            disabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2)),
                                            border: OutlineInputBorder(
                                                gapPadding: 12,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2))),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Video link",
                                        style: t1,
                                      ),
                                      TextFormField(
                                        controller: linkController[index],
                                        validator: nonEmptyValidator,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                            hintText: "Paste the link here",
                                            filled: true,
                                            fillColor: Colors.white,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2)),
                                            disabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2)),
                                            border: OutlineInputBorder(
                                                gapPadding: 12,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 2))),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                index != 0
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            linkController[index].clear();
                                            linkController[index].dispose();
                                            linkController.removeAt(index);
                                          });
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Color.fromARGB(255, 255, 0, 0),
                                          size: 25,
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          chapterController.add(TextEditingController());
                          descriptionController.add(TextEditingController());
                          linkController.add(TextEditingController());
                          print(linkController);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: screenWidth / 6,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(22)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle_outline),
                                Text(
                                  "Add one more chapter",
                                  style: t1.copyWith(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Amount",
                      style: t1,
                    ),
                    TextFormField(
                      controller: _amountController,
                      validator: validatorForAmount,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.currency_rupee),
                          hintText: "if the course is free , type 0",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2)),
                          disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2)),
                          border: OutlineInputBorder(
                              gapPadding: 12,
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: screenWidth / 5,
                        height: 50,
                        child: BlocBuilder<CourseBloc, CourseState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return ElevatedButton.icon(
                                style: ButtonStyle(
                                    elevation: MaterialStatePropertyAll(22)),
                                onPressed:
                                    null, // Disable the button during loading
                                icon: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                                label: Text(
                                  'Uploading...',
                                  style: t1,
                                ),
                              );
                            } else {
                              return ElevatedButton.icon(
                                style: ButtonStyle(
                                    elevation: MaterialStatePropertyAll(22)),
                                onPressed: () => uploadCourse(context),
                                icon: Icon(Icons.save),
                                label: Text(
                                  "Save and submit data",
                                  style: t1,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Future<void> _pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );
    if (result != null) {
      setState(() {
        _pickedFile = result;
      });
    }
  }

  void uploadCourse(BuildContext context) async {
    if (newImage == null || _pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Both cover image and document are required.",
              style: t1.copyWith(color: Colors.black),
            ),
          ],
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    } else {
      try {
        // Upload cover image
        firebasestorage.Reference imageRef = firebasestorage
            .FirebaseStorage.instance
            .ref("course_${_titleController.text.trim()}");
        firebasestorage.UploadTask uploadImageTask =
            imageRef.putData(newImage!);
        String coverImageUrl =
            await (await uploadImageTask).ref.getDownloadURL();

        // Upload additional document
        FilePickerResult result = _pickedFile!;
        firebasestorage.Reference docRef = firebasestorage
            .FirebaseStorage.instance
            .ref("course_docs/${result.files.first.name}");
        firebasestorage.UploadTask uploadDocTask =
            docRef.putData(result.files.first.bytes!);
        String docUrl = await (await uploadDocTask).ref.getDownloadURL();

        // Add course data to Firestore
        courseID = FirebaseFirestore.instance.collection("courses").doc().id;
        Map<String, dynamic> data = {
          "courseID": courseID,
          "photo": coverImageUrl,
          "title": _titleController.text.trim(),
          "overview": _overViewController.text.trim(),
          "chapters": chapterController
              .map((controller) => controller.text.trim())
              .toList(),
          "description": descriptionController
              .map((controller) => controller.text.trim())
              .toList(),
          "videos": linkController
              .map((controller) => controller.text.trim())
              .toList(),
          "document": docUrl,
          "amount": _amountController.text.trim()
        };

        // Dispatch add course event
        context
            .read<CourseBloc>()
            .add(AddCourseEvent(data: data, CourseId: courseID!));

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Course added successfully !"),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        print("Error uploading course: $e");
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error adding course. Please try again later. $e"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  String? nonEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  String? validatorForAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid amount.';
    }
    final RegExp regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(value)) {
      return 'Please enter numbers only.';
    }
    return null;
  }
}
