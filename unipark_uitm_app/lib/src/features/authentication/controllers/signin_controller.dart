import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/user/user_repository.dart';
import 'package:unipark_uitm_app/src/data/repositories/authentication/authentication_repository.dart';
import 'package:unipark_uitm_app/src/features/core/controllers/user_controller.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final email = TextEditingController(); // controller for email input
  final password = TextEditingController(); // controller for password input
  final hidePassword = true.obs; // Observable for hiding/showing password
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>(); // Form key for form validation
  final userController = Get.put(UserController());
  final _firebaseMessaging = FirebaseMessaging.instance;
  final userRepository = Get.put(UserRepository());

  // Call this function on register page ui
  Future<void> signInUser() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!signInFormKey.currentState!.validate()) return;

      // Sign In user with Firebase Authentication
      await AuthenticationRepository.instance.signInWithEmailAndPassword(email.text.trim(), password.text.trim());

      // fetch the FCM token for this device
      final fCMToken = await _firebaseMessaging.getToken();

      // Update device token
      Map<String, dynamic> updatedFCMToken = {'device_token': fCMToken};
      await userRepository.updateSingleField(updatedFCMToken);

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
    }
  }

  Future<void> googleSignIn() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Google Authentication
      final userCredential = await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredential);

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}