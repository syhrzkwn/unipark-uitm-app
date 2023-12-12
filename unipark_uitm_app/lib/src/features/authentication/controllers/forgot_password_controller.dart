import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/authentication/authentication_repository.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/reset_password_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  // Send Reset Password Email
  sendEmailResetPassword() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!forgotPasswordFormKey.currentState!.validate()) return;

      // Send Email to reset password
      await AuthenticationRepository.instance.sendEmailResetPassword(email.text.trim());

      // Show success message
      SnackBarTheme.successSnackBar(title: 'Email Sent', message: 'Secure link successfully sent to your email to reset your password.');

      // Redirect
      Get.to(() => ResetPasswordPage(email: email.text.trim()));

    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  resendEmailResetPassword(String email) async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Send Email to reset password
      await AuthenticationRepository.instance.sendEmailResetPassword(email);

      // Show success message
      SnackBarTheme.successSnackBar(title: 'Email Sent', message: 'Secure link successfully sent to your email to reset your password.');

    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}