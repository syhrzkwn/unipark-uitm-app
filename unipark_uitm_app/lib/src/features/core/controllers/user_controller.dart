import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/authentication/authentication_repository.dart';
import 'package:unipark_uitm_app/src/data/repositories/user/user_repository.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/signin_page.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/re_signin_page.dart';
import 'package:unipark_uitm_app/src/features/core/models/user_model.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final hidePassword = true.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reSignInKey = GlobalKey<FormState>();
  final _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      final user = await userRepository.fetchUserInformation();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: 'Something went wrong. Please try again.');
    }
  }

  // Save user record when sign-in with Google
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // fetch the FCM token for this device
      final fCMToken = await _firebaseMessaging.getToken();

      if (userCredential != null) {

        // Map Data
        final user = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
          studentId: 0,
          email: userCredential.user!.email ?? '',
          phone: userCredential.user!.phoneNumber ?? '',
          deviceToken: fCMToken!,
        );

        // Save User Data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: 'Something went wrong. You can re-save your information in your profile.');
    }
  }

  void deleteUserAccount() async {
    try {
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          await auth.logout();
        } else if (provider == 'password') {
          Get.to(() => const ReSignInPage());
        }
      }
    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: 'Something went wrong. You can resave your information in your profile.');
    }
  }

  Future<void> reSignInUserWithEmailAndPassword() async {
    try {
      final auth = AuthenticationRepository.instance;

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!reSignInKey.currentState!.validate()) return;

      await auth.reSignInWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await auth.deleteAccount();
      await auth.logout();

      SnackBarTheme.successSnackBar(title: 'Success', message: 'Your account has been deleted.');

      Get.offAll(() => const SigninPage());
    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: 'Something went wrong. Please try again.');
    }
  }
}