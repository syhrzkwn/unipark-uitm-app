import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/user/user_repository.dart';
import 'package:unipark_uitm_app/src/features/core/controllers/user_controller.dart';
import 'package:unipark_uitm_app/src/features/profile/pages/profile_edit_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class UpdateStudentIdController extends GetxController {
  static UpdateStudentIdController get instance => Get.find();

  final studentId = TextEditingController(); // controller for name input
  final userController = UserController.instance;
  final userRespository = Get.put(UserRepository());
  GlobalKey<FormState> updateStudentIdFormKey = GlobalKey<FormState>(); // Form key for form validation

  @override
  void onInit() {
    initializeStudentId();
    super.onInit();
  }

  Future<void> initializeStudentId() async {
    studentId.text = userController.user.value.studentId;
  }

  Future<void> updateStudentId() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!updateStudentIdFormKey.currentState!.validate()) return;

      // Update user name
      Map<String, dynamic> udpatedStudentId = {'student_id': studentId.text.trim()};
      await userRespository.updateSingleField(udpatedStudentId);

      userController.user.value.studentId = studentId.text.trim();

      SnackBarTheme.successSnackBar(title: 'Success', message: 'Your Student ID has been updated.');

      Get.off(() => const ProfileEditPage());

    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}