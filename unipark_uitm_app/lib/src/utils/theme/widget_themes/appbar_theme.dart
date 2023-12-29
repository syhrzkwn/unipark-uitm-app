import 'package:flutter/material.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';

class AppBarThemeData {
  static AppBarTheme lightAppBarTheme = const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: blackColor),
    titleTextStyle: TextStyle(color: blackColor, fontFamily: 'Epilogue', fontWeight: FontWeight.bold, fontSize: 16),
    centerTitle: true,
    elevation: 0,
  );

  static AppBarTheme darkAppBarTheme = const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: whiteColor),
    titleTextStyle: TextStyle(color: whiteColor, fontFamily: 'Epilogue', fontWeight: FontWeight.bold, fontSize: 16),
    centerTitle: true,
    elevation: 0,
  );
}