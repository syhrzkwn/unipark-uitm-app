import 'package:flutter/material.dart';
import 'package:unipark_uitm_app/src/constants/colors.dart';

class AppBarThemeData {
  static AppBarTheme lightAppBarTheme = const AppBarTheme(
    iconTheme: IconThemeData(color: textColor1),
    color: textColor1,
    elevation: 0,
  );

  static AppBarTheme darkAppBarTheme = const AppBarTheme(
    iconTheme: IconThemeData(color: whiteColor),
    color: whiteColor,
    elevation: 0,
  );
}