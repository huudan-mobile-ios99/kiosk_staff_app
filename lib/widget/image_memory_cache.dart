import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:uuid/uuid.dart';

class ImageMemoryCacheWidget extends StatefulWidget {
  final AsyncSnapshot<Object?> snapshot;

  const ImageMemoryCacheWidget({Key? key, required this.snapshot, }) : super(key: key);

  @override
  _ImageMemoryCacheWidgetState createState() => _ImageMemoryCacheWidgetState();
}

class _ImageMemoryCacheWidgetState extends State<ImageMemoryCacheWidget> {
  late Uint8List bytesImage;
  late String uniqueKey;

  @override
  void initState() {
    super.initState();
    _prepareImage();
  }

  void _prepareImage() {
    if (widget.snapshot.data != null && widget.snapshot.data is String) {
      final String data = widget.snapshot.data as String;
      bytesImage = const Base64Decoder().convert(data);
      uniqueKey = const Uuid().v4(); // Generate a unique key using UUID
    } else {
      // Handle the case where data is not a String
      bytesImage = Uint8List(0); // An empty image or some default image
      uniqueKey = const Uuid().v4();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    if (widget.snapshot.data == null || widget.snapshot.data == 'null') {
      return const Center(child: Icon(Icons.person, color: Colors.grey));
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedMemoryImage(
        uniqueKey: uniqueKey,
        bytes: bytesImage,
        fit: BoxFit.cover,
        placeholder: const CircularProgressIndicator(),
        errorWidget: const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}