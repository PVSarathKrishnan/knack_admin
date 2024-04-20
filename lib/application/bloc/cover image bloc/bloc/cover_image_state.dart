part of 'cover_image_bloc.dart';

sealed class CoverImageState extends Equatable {
  const CoverImageState();

  @override
  List<Object> get props => [];
}

final class CoverImageInitial extends CoverImageState {}

class ImageUpdateState extends CoverImageState {
  final Uint8List imageFile;
  ImageUpdateState({required this.imageFile});

  @override
  List<Object> get props => [imageFile];
}
