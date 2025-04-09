import 'package:flutter/material.dart';
import 'package:vegas_point_portal/util/mycolor.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';
import 'package:vegas_point_portal/widget/image_asset.dart';
import 'package:vegas_point_portal/widget/widget.dart';

mysnackBar(message) {
  return SnackBar(
    // backgroundColor: MyColor.white,
    duration: const Duration(milliseconds: 400),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        textCustomNormalColor(
          text: message,
          color: MyColor.white,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(
          width: StringFactory.padding,
        ),
        imageAssetSmall('assets/icons/success.png'),
      ],
    ),
    // action: SnackBarAction(
    //   textColor: Colors.grey,
    //   label: 'CLOSE',
    //   onPressed: () {},
    // )
  );
}

mysnackbarWithContext(
    {required BuildContext context, required String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 400),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        textCustomNormalColor(
          text: message,
          color: MyColor.white,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(
          width: StringFactory.padding,
        ),
        imageAssetSmall('assets/icons/success.png'),
      ],
    ),
  ));
}

mysnackbarWithContextError(
    {required BuildContext context, required String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // backgroundColor: MyColor.white,
      duration: const Duration(milliseconds: 400),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          textCustomNormalColor(
            text: message,
            color: MyColor.white,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(
            width: StringFactory.padding,
          ),
          imageAssetSmall('assets/icons/error.png'),
        ],
      )));
}

mysnackBarError(message) {
  return SnackBar(
    // backgroundColor: MyColor.white,
    duration: const Duration(milliseconds: 400),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        textCustomNormalColor(
          text: message,
          color: MyColor.white,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(
          width: StringFactory.padding,
        ),
        imageAssetSmall('assets/icons/error.png'),
      ],
    ),
    // action: SnackBarAction(
    //   textColor: Colors.grey,
    //   label: 'CLOSE',
    //   onPressed: () {},
    // )
  );
}
