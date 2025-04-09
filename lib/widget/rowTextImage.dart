import 'package:flutter/material.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/image_asset.dart';
import 'package:vegas_point_portal/widget/widget.dart';

Widget rowTextImage(text, assetPath) {
  return Wrap(
    children: [
      Container(
      padding: const EdgeInsets.all(StringFactory.padding4),
      decoration: BoxDecoration(
        color:MyColor.grey_bg,
        border: Border.all(
          color:MyColor.grey_tab,
          width: 1.0
        ),
        borderRadius: BorderRadius.circular(StringFactory.padding8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          imageAssetSmall(assetPath),
          const SizedBox(width: StringFactory.padding4),
          textCustom(
            text: text,
            size: 16,
          ),
        ],
      ),
    ),
    ],
  );
}
