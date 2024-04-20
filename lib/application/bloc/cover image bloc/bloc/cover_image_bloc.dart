import 'dart:async';
import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cover_image_event.dart';
part 'cover_image_state.dart';

class CoverImageBloc extends Bloc<CoverImageEvent, CoverImageState> {
  CoverImageBloc() : super(CoverImageInitial()) {
    on<ImageUpdateEvent>(updateImage);
    on<ImagePickerInitial>(initialImage);
  }

  FutureOr<void> updateImage(
      ImageUpdateEvent event, Emitter<CoverImageState> emit) async {
    try {
      Uint8List? file = await ImagePickerWeb.getImageAsBytes();
      emit(ImageUpdateState(imageFile: file!));
    } catch (e) {
      print("exception : $e");
    }
  }

  FutureOr<void> initialImage(
      ImagePickerInitial event, Emitter<CoverImageState> emit) async {
    emit(CoverImageInitial());
  }
}
