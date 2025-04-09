// events.dart
part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
  
  @override
  List<Object> get props => [];
}

class ImageFetched extends ImageEvent {
  final String customerNumber;

  const ImageFetched(this.customerNumber);

  @override
  List<Object> get props => [customerNumber];
}