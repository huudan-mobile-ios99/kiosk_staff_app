import 'package:flutter/material.dart';
import 'package:vegas_point_portal/util/mycolor.dart';

Future selectDate({
  required BuildContext context,
}) async {
  final DateTime? picked = await showDatePicker(
      useRootNavigator: true,
      context: context,
      initialEntryMode:DatePickerEntryMode.calendar,
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
        data: ThemeData(
          splashColor: MyColor.bedge,
          primaryColor: Colors.yellow,
          // fontFamily: 'Quicksand',
          platform: TargetPlatform.windows,
          colorScheme:  ColorScheme.fromSwatch(
                  cardColor: MyColor.white_text,
                  errorColor: MyColor.red,
                  backgroundColor: MyColor.yellow_gradient2,
                  accentColor: MyColor.yellow_accent
                ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle:  const TextStyle(color: Colors.black),
              backgroundColor: Colors.white, // Background color
            ),
          ),
          primaryTextTheme: const TextTheme(
          ),
          textSelectionTheme: const TextSelectionThemeData(
          )
        ),
        child: child!,
      );
      },
      cancelText: 'CANCEL',
      confirmText: "OKAY",
      helpText: 'Select Date',
      barrierColor: MyColor.grey_tab.withOpacity(.25),
      barrierLabel: "Choose date from date picker",
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(DateTime.now().year, 12, 31));
  return picked;
}
