import 'package:flutter/material.dart';

Widget imageAsset(
  assetPath,
) {
  return Image.asset(
    '$assetPath',
    fit: BoxFit.contain,
    width: 45.0,
    height: 45.0,
  );
}

Widget imageAssetSmall(
  assetPath,
) {
  return Wrap(
    children: [
      Image.asset(
        '$assetPath',
        fit: BoxFit.contain,
        width: 25.0,
        height: 25.0,
      ),
    ],
  );
}
