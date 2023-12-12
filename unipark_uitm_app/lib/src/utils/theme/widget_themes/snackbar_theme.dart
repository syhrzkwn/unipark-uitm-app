import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';

class SnackBarTheme {
  static successSnackBar({required title, message = '', duration = 5}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: false,
      colorText: whiteColor,
      backgroundColor: textColor1,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(20.0),
        borderRadius: 5.0,
      icon: const Icon(Bootstrap.check_circle_fill, color: Colors.green,)
    );
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: false,
        colorText: whiteColor,
        backgroundColor: textColor1,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(20.0),
        borderRadius: 5.0,
        icon: const Icon(Bootstrap.exclamation_circle_fill, color: Colors.orange,)
    );
  }

  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(
        title,
        message,
        isDismissible: true,
        shouldIconPulse: false,
        colorText: whiteColor,
        backgroundColor: textColor1,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(20.0),
        borderRadius: 5.0,
        icon: const Icon(Bootstrap.exclamation_circle_fill, color: Colors.red,)
    );
  }
}