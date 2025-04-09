import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/image_asset.dart';
import 'package:vegas_point_portal/widget/widget.dart';

showLoaderDialogIcon(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: MyColor.white.withOpacity(.85),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CupertinoActivityIndicator(radius: 10), 
        const SizedBox(width: StringFactory.padding,),
        imageAssetSmall('assets/icons/point.png'),
        Container(
            margin: const EdgeInsets.only(left: StringFactory.padding),
            child: textCustom(text: "Loading, Please wait for a moment")),
        // SizedBox(width: StringFactory.padding16,),
        // IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        // icon: Icon(Icons.close,color:MyColor.blue))
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    useRootNavigator: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
