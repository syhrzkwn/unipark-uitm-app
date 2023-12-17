import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/user/user_repository.dart';
import 'package:unipark_uitm_app/src/features/core/controllers/user_controller.dart';
import 'package:unipark_uitm_app/src/features/profile/pages/profile_edit_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/helpers/formatter.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class UpdatePhoneController extends GetxController {
  static UpdatePhoneController get instance => Get.find();

  final phone = TextEditingController(); // controller for name input
  final userController = UserController.instance;
  final userRespository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserPhoneFormKey = GlobalKey<FormState>(); // Form key for form validation

  @override
  void onInit() {
    initializePhoneNumber();
    super.onInit();
  }

  Future<void> initializePhoneNumber() async {
    phone.text = userController.user.value.phone;
  }

  // Format phone number, example: +6012-3456789
  String get formattedPhoneNo => Formatter.formatPhoneNumber(phone.text.trim());

  Future<void> updateUserPhone() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!updateUserPhoneFormKey.currentState!.validate()) return;

      // Update user name
      Map<String, dynamic> udpatedPhone = {'phone': formattedPhoneNo};
      await userRespository.updateSingleField(udpatedPhone);

      userController.user.value.phone = formattedPhoneNo;

      SnackBarTheme.successSnackBar(title: 'Success', message: 'Your phone number has been updated.');

      Get.off(() => const ProfileEditPage());

    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}