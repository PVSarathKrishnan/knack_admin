// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:knack_admin/presentation/style/text_style.dart';

// class CustomFilePickerWidget extends StatefulWidget {
//   const CustomFilePickerWidget({super.key});

//   @override
//   _CustomFilePickerWidgetState createState() => _CustomFilePickerWidgetState();
// }

// class _CustomFilePickerWidgetState extends State<CustomFilePickerWidget> {
//    FilePickerResult? _pickedFile;

//   Future<void> _pickFile() async {
//     final FilePickerResult? result =
//         await FilePicker.platform.pickFiles(allowMultiple: false);
//     if (result != null) {
//       setState(() {
//         _pickedFile = result;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String fileName = _pickedFile?.files.first.name ?? '';
//     return   }
// }
