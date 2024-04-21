import 'dart:async';

import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc() : super(DocumentInitial()) {
    on<DocUpdateEvent>(updateDoc);
    on<DocPickerInitial>(initialDoc);
  }

  FutureOr<void> updateDoc(
      DocUpdateEvent event, Emitter<DocumentState> emit) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        Uint8List? file = result.files.first.bytes;
        if (file != null) {
          emit(DocumentUpdateState(docFile: file));
        } else {
          print("error in file  bytes");
        }
      } else {
        print("file picking cancelled");
      }
    } catch (e) {
      print("doc uploading Exception: $e");
    }
  }

  FutureOr<void> initialDoc(
      DocPickerInitial event, Emitter<DocumentState> emit) async {
    emit(DocumentInitial());
  }
}
