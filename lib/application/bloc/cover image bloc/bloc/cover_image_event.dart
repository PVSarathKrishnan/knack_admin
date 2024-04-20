part of 'cover_image_bloc.dart';

sealed class CoverImageEvent extends Equatable {
  const CoverImageEvent();

  @override
  List<Object> get props => [];
}

class ImagePickerInitial extends CoverImageEvent{}

class ImageUpdateEvent extends CoverImageEvent{}