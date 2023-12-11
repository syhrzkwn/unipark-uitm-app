import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperFunction {

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }
}