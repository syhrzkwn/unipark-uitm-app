import 'package:flutter/material.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/appbar_theme.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/button_theme.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/text_theme.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/textform_field_theme.dart';

class AppTheme {

  AppTheme._();
  
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Inter',
    brightness: Brightness.light,
    textTheme: AppTextTheme.lightTextTheme,
    primarySwatch: const MaterialColor(0xFF7045F2, <int, Color>{
      50: Color(0x1A7045F2),
      100: Color(0x337045F2),
      200: Color(0x667045F2),
      300: Color(0x8C7045F2),
      400: Color(0xBB7045F2),
      500: Color(0xFF7045F2),
      600: Color(0xFF9E5CF2),
      700: Color(0xFFD95CF2),
      800: Color(0xFFF25CF2),
      900: Color(0xFFFA7DF2),
    }),
    appBarTheme: AppBarThemeData.lightAppBarTheme,
    elevatedButtonTheme: AppButtonTheme.lightButtonTheme,
    outlinedButtonTheme: AppButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Inter',
    brightness: Brightness.dark,
    textTheme: AppTextTheme.darkTextTheme,
    primarySwatch: const MaterialColor(0xFF7045F2, <int, Color>{
      50: Color(0x1A7045F2),
      100: Color(0x337045F2),
      200: Color(0x667045F2),
      300: Color(0x8C7045F2),
      400: Color(0xBB7045F2),
      500: Color(0xFF7045F2),
      600: Color(0xFF9E5CF2),
      700: Color(0xFFD95CF2),
      800: Color(0xFFF25CF2),
      900: Color(0xFFFA7DF2),
    }),
    appBarTheme: AppBarThemeData.darkAppBarTheme,
    elevatedButtonTheme: AppButtonTheme.darkButtonTheme,
    outlinedButtonTheme: AppButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.darkInputDecorationTheme,
  );
}
