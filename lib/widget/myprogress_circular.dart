import 'package:flutter/material.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/image_asset.dart';
import 'package:vegas_point_portal/widget/widget.dart';

Widget myprogress_circular(){
	return const Center(
                    child: CircularProgressIndicator(
                    color: MyColor.grey,
                    strokeWidth: 1,
                    backgroundColor: MyColor.grey_tab,
                  ));
}



Widget myprogress_circular_icon() {
  return Center(
    child: Wrap(
      children: [
        Container(
          padding: const EdgeInsets.all(StringFactory.padding),
          decoration: BoxDecoration(
            color:MyColor.white,
            border: Border.all(color:MyColor.grey_tab),
            borderRadius: BorderRadius.circular(StringFactory.padding16)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator.adaptive(),const SizedBox(width: StringFactory.padding,),
              imageAssetSmall('assets/icons/point.png'),
              textCustom2(text: "Loading, Please wait for a moment",size: 14),
            ],
          ),
        ),
      ],
    ),
  );
}