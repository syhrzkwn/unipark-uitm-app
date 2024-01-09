import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/authentication/authentication_repository.dart';
import 'package:unipark_uitm_app/src/data/repositories/rfid/rfid_repository.dart';
import 'package:unipark_uitm_app/src/features/rfid/models/rfid_model.dart';
import 'package:unipark_uitm_app/src/features/rfid/pages/rfid_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/helpers/formatter.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class RfidAddController extends GetxController {
  static RfidAddController get instance => Get.find();

  final ownerName = TextEditingController();
  final plateNumber = TextEditingController();
  final rfidTagId = TextEditingController();
  final vehicleBrand = TextEditingController();
  final vehicleModel = TextEditingController();
  final vehicleYear = TextEditingController();
  GlobalKey<FormState> addRfidKey = GlobalKey<FormState>();

  Future<void> saveRfidInformation() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!addRfidKey.currentState!.validate()) return;

      DateTime currentDate = DateTime.now();
      DateTime expiredDate = currentDate.add(const Duration(days: 365));

      // Format DateTiem, example: 2024-01-01
      String formattedCurrentDate = Formatter.formatDate(currentDate);
      String formattedExpiredDate = Formatter.formatDate(expiredDate);

      // Save RFID data in Firebase Firestore
      final newRfid = RfidModel(
        id: rfidTagId.text.trim(),
        userId: AuthenticationRepository.instance.authUser?.uid,
        ownerName: ownerName.text.trim(),
        plateNumber: plateNumber.text.removeAllWhitespace.toUpperCase().trim(),
        rfidTagId: rfidTagId.text.trim(),
        rfidStatus: true,
        rfidRegisteredDate: formattedCurrentDate,
        rfidExpiredDate: formattedExpiredDate,
        vehicleBrand: vehicleBrand.text.trim(),
        vehicleModel: vehicleModel.text.trim(),
        vehicleYear: vehicleYear.text.trim(),
      );

      final rfidRepository = Get.put(RfidRepository());
      await rfidRepository.saveRfidRecord(newRfid);

      SnackBarTheme.successSnackBar(title: 'Success',message: 'Your RFID has been successfully added.');

      Get.off(() => const RFIDPage());

    } catch (e) {
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}