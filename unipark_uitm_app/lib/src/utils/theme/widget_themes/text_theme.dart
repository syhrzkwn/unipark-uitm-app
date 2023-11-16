import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    displaySmall: TextStyle(color: Colors.black, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    displayMedium: TextStyle(color: Colors.black, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    displayLarge: TextStyle(color: Colors.black, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: Colors.black, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(color: Colors.black, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(color: Colors.black, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    titleSmall: TextStyle(color: Color(0xFF454545), fontWeight: FontWeight.normal),
    titleMedium: TextStyle(color: Color(0xFF454545), fontWeight: FontWeight.normal),
    titleLarge: TextStyle(color: Color(0xFF454545), fontWeight: FontWeight.normal),
    labelSmall: TextStyle(color: Color(0xFF454545)),
    labelMedium: TextStyle(color: Color(0xFF454545)),
    labelLarge: TextStyle(color: Color(0xFF454545)),
    bodySmall: TextStyle(color: Color(0xFF454545)),
    bodyMedium: TextStyle(color: Color(0xFF454545)),
    bodyLarge: TextStyle(color: Color(0xFF454545), height: 1.5),
  );

    static TextTheme darkTextTheme = const TextTheme(
    displaySmall: TextStyle(color: Colors.white, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    displayMedium: TextStyle(color: Colors.white, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    displayLarge: TextStyle(color: Colors.white, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: Colors.white, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(color: Colors.white, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(color: Colors.white, fontFamily: 'Epilogue', fontWeight: FontWeight.bold),
    titleSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
    titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
    labelSmall: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white, height: 1.5),
  );
}
