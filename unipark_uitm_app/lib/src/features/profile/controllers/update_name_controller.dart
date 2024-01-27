import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/user/user_repository.dart';
import 'package:unipark_uitm_app/src/features/core/controllers/user_controller.dart';
import 'package:unipark_uitm_app/src/features/profile/pages/profile_edit_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final name = TextEditingController(); // controller for name input
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>(); // Form key for form validation

  @override
  void onInit() {
    initializeName();
    super.onInit();
  }

  Future<void> initializeName() async {
    name.text = userController.user.value.name;
  }
  
  Future<void> updateUserName() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) return;
      
      // Update user name
      Map<String, dynamic> updatedName = {'name': name.text.trim()};
      await userRepository.updateSingleField(updatedName);

      userController.user.value.name = name.text.trim();

      SnackBarTheme.successSnackBar(title: 'Success', message: 'Your name has been updated.');

      Get.off(() => const ProfileEditPage());

    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
