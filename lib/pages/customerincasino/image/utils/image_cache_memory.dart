// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class CacheImage extends StatelessWidget {
//   final String tag;
//   final Uint8List imageBytes;

//   const CacheImage({
//     Key? key,
//     required this.tag,
//     required this.imageBytes,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image(image: CacheImageProvider(tag, imageBytes));
//   }
// }

// class CacheImageProvider extends ImageProvider<CacheImageProvider> {
//   final String tag;
//   final Uint8List img;

//   CacheImageProvider(this.tag, this.img);

//   @override
//   ImageStreamCompleter load(
//       CacheImageProvider key,
//       Future<Codec> Function(Uint8List,
//               {bool allowUpscaling, int? cacheHeight, int? cacheWidth})
//           decode) {
//     return MultiFrameImageStreamCompleter(
//       codec: _loadAsync(decode),
//       scale: 1.0,
//       debugLabel: tag,
//       informationCollector: () sync* {
//         yield ErrorDescription('Tag: $tag');
//       },
//     );
//   }

//   Future<Codec> _loadAsync(
//       DecoderCallback decode) async {
//     final Uint8List bytes = img;

//     if (bytes.lengthInBytes == 0) {
//       PaintingBinding.instance!.imageCache!.evict(this);
//       throw StateError('$tag is empty and cannot be loaded as an image.');
//     }

//     return await decode(bytes);
//   }
  
//   @override
//   Future<CacheImageProvider> obtainKey(ImageConfiguration configuration) {
//     return SynchronousFuture<CacheImageProvider>(this);
//   }

//   @override
//   bool operator ==(Object other) {
//     if (other.runtimeType != runtimeType) return false;
//     bool res = other is CacheImageProvider && other.tag == tag;
//     return res;
//   }

//   @override
//   int get hashCode => tag.hashCode;

//   @override
//   String toString() =>
//       '${objectRuntimeType(this, 'CacheImageProvider')}("$tag")';
// }