import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/vehicle/vehicle_repository.dart';
import 'package:unipark_uitm_app/src/features/vehicle/models/vehicle_model.dart';
import 'package:unipark_uitm_app/src/features/vehicle/pages/vehicles_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class VehicleAddController extends GetxController {
  static VehicleAddController get instance => Get.find();

  final brand = TextEditingController();
  final colour = TextEditingController();
  final model = TextEditingController();
  final ownerName = TextEditingController();
  final plateNumber = TextEditingController();
  GlobalKey<FormState> addVehicleKey = GlobalKey<FormState>();

  Future<void> saveVehicleRecord() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!addVehicleKey.currentState!.validate()) return;

      // Save vehicle data in Firebase Firestore
      final newVehicle = VehicleModel(
        brand: brand.text.trim(),
        colour: colour.text.trim(),
        model: model.text.trim(),
        ownerName: ownerName.text.trim(),
        plateNumber: plateNumber.text.toUpperCase().trim(),
        rfid: false,
      );

      final vehicleRepository = Get.put(VehicleRepository());
      await vehicleRepository.saveVehicleRecord(newVehicle);

      SnackBarTheme.successSnackBar(title: 'Success',message: 'Your vehicle has been successfully added.');

      Get.off(() => const VehiclesPage());

    } catch (e) {
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}