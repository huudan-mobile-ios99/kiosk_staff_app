import 'package:flutter/material.dart';
import 'package:vegas_point_portal/util/detect_platform.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/widget/widget.dart';

Widget itemText(point, pointFormat) {
  return Wrap(
    children: [
      Container(
      color: MyColor.green,
      padding: const EdgeInsets.all(1.0),
      child: textCustomNormalColor(
          text: point == -1 ? '0 PTS' : '$pointFormat PTS',
          color: MyColor.white,
          size: detectPlatform()==false ? 11.0 : 9.5,
          fontWeight: FontWeight.bold),
    ),
    ]
  );
}
Widget itemTextBlank() {
  return Wrap(
    children: [
      Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(1.0),
      child: textCustomNormalColor(
          text: "",
          color: MyColor.white,
          size: 11,
          fontWeight: FontWeight.bold),
    ),
    ]
  );
}


