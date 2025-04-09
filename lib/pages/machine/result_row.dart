import 'package:flutter/material.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';

Widget resultRow({required BuildContext context, required int total}) {
  return //show total results
      Positioned(
          bottom: StringFactory.padding,
          right: StringFactory.padding,
          child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: StringFactory.padding4,
                  horizontal: StringFactory.padding),
              decoration: BoxDecoration(
                  color: MyColor.grey_tab,
                  borderRadius: BorderRadius.circular(StringFactory.padding16)),
              child:
                  // textCustom(text:"Total Results: ${machineList.length}")
                  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.filter_list, color: MyColor.yellow_accent),
                  const SizedBox(
                    width: StringFactory.padding,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Total ',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: '$total',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColor.blue_fb,
                                fontSize: StringFactory.padding16)),
                        const TextSpan(text: ' Results'),
                      ],
                    ),
                  ),
                ],
              )));
}
