import 'package:flutter/material.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/widget.dart';

Widget itemListHistory({name,number,datetime}) {
  return Container(
    padding: const EdgeInsets.all(StringFactory.padding4),
    decoration: BoxDecoration(
      border: Border.all(color:MyColor.grey_tab,width: .5),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        textCustomGrey(text:name,size: 9.5),
        textCustom(text:number,size: 11.5),
        textCustomGrey(text:datetime,size: 8.5),
      ],
    ),
  );
}
