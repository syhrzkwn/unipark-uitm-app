import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/authentication/authentication_repository.dart';
import 'package:unipark_uitm_app/src/data/repositories/user/user_repository.dart';
import 'package:unipark_uitm_app/src/features/core/models/user_model.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final name = TextEditingController(); // controller for name input
  final studentId = TextEditingController(); // controller for student id input
  final email = TextEditingController(); // controller for email input
  final phone = TextEditingController(); // controller for phone input
  final password = TextEditingController(); // controller for password input
  final hidePassword = true.obs; // Observable for hiding/showing password
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>(); // Form key for form validation

  // Call this function on register page ui
  void registerUser() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!registerFormKey.currentState!.validate()) return;

      // Register user in the Firebase Authentication
      final userCredential = await AuthenticationRepository.instance.createUserWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save Authenticated user data in Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        name: name.text.trim(),
        studentId: studentId.text.trim(),
        email: email.text.trim(),
        phone: phone.text.trim(),
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      AuthenticationRepository.instance.screenRedirect();

      // Show success message
      SnackBarTheme.successSnackBar(title: 'Welcome',message: 'Your account has been created.');

    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
    }
  }
}