import 'package:flutter/material.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';

class TextFormFieldTheme {

  TextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: textColor1),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: textColor1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(width: 2, color: primaryColor)),
      );

  static InputDecorationTheme darkInputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: whiteColor),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: whiteColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(width: 2, color: primaryColor)),
      );
}