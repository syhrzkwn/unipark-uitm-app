import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/user/user_repository.dart';
import 'package:unipark_uitm_app/src/features/core/models/user_model.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {

        // Map Data
        final user = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
          studentId: '',
          email: userCredential.user!.email ?? '',
          phone: userCredential.user!.phoneNumber ?? '',
        );

        // Save User Data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: 'Something went wrong. You can resave your information in your profile.');
    }
  }
}