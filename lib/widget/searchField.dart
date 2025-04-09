import 'package:flutter/material.dart';
import 'package:vegas_point_portal/util/stringFactory.dart';

Widget searchTextField(
    {scrollController,
    String? hint,
    Function? onTap,
    Function? onEditingComplete,
    Function? onSubmit,
    Function? onChange,
    bool hasInitValue = false,
    valueInit,
    controller}) {
  return TextFormField(
    autofocus: false, //Display the keyboard when TextField is displayed
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.white, fontSize: StringFactory.padding20),
    scrollController: scrollController,
    keyboardType: TextInputType.number,
    textAlign: TextAlign.left,
    onEditingComplete: () {
      onEditingComplete!();
    },
    onFieldSubmitted: (value) => onSubmit!(value),
    // onTap: () => onTap!(),
    // onChanged: (value) => onChange!(value),
    controller: TextEditingController(text: valueInit),
    textInputAction:
        TextInputAction.search, //Specify the action button on the keyboard
    decoration: InputDecoration(
      //Style of TextField
      enabledBorder: const UnderlineInputBorder(
          //Default TextField border
          borderSide: BorderSide.none),
      focusedBorder: const UnderlineInputBorder(
          //Borders when a TextField is in focus
          borderSide: BorderSide.none),
      hintText: hint, //Text that is displayed when nothing is entered.
      hintStyle: const TextStyle(
          //Style of hintText
          color: Colors.white,
          fontSize: StringFactory.padding20),
    ),
  );
}
Widget searchTextFieldSimple(
    {
    Function? onSubmitted,
    controller}) {
  return TextField(
    autofocus: false, //Display the keyboard when TextField is displayed
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.white, fontSize: StringFactory.padding20),
    keyboardType: TextInputType.number,
    textAlign: TextAlign.left,
    onSubmitted: (value) => onSubmitted!(value),
    controller: controller,
    textInputAction:TextInputAction.search, //Specify the action button on the keyboard
    decoration: const InputDecoration(
      //Style of TextField
      enabledBorder:  UnderlineInputBorder(
          //Default TextField border
          borderSide: BorderSide.none),
      focusedBorder:  UnderlineInputBorder(
          //Borders when a TextField is in focus
          borderSide: BorderSide.none),
      hintText: null, //Text that is displayed when nothing is entered.
      hintStyle:  TextStyle(
          //Style of hintText
          color: Colors.white,
          fontSize: StringFactory.padding20),
    ),
  );
}
