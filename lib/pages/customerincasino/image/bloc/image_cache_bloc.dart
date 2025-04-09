// import 'dart:convert';

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vegas_point_portal/service/api_service.dart';
// // states.dart
// import 'dart:typed_data';

// import 'package:vegas_point_portal/util/stringFactory.dart';
// part 'image_event.dart';
// part 'image_state.dart';
// class ImageBloc extends Bloc<ImageEvent, ImageState> {
//   final ServiceAPIs service;

//   ImageBloc({required this.service}) : super(ImageInitial()) {
//     on<ImageFetched>(_onImageFetched);
//   }

//   Future<void> _onImageFetched(ImageFetched event, Emitter<ImageState> emit) async {
//     emit(ImageLoading());
//     try {
//       final imageString = await service.postCustomerImage(
//         customerNumber: event.customerNumber,
//         computerName: StringFactory.COMPUTERNAME,
//       );

//       if (imageString == 'null') {
//         emit(ImageError('No image available'));
//       } else {
//         final bytesImage = const Base64Decoder().convert(imageString);
//         emit(ImageLoaded(bytesImage));
//       }
//     } catch (e) {
//       emit(ImageError(e.toString()));
//     }
//   }
// }