part of 'image_bloc.dart';


abstract class ImageState extends Equatable {
  const ImageState();
  
  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final Uint8List image;

  const ImageLoaded(this.image);

  @override
  List<Object> get props => [image];
}

class ImageError extends ImageState {
  final String errorMessage;

  const ImageError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}