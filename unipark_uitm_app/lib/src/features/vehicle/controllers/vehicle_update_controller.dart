import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/vehicle/vehicle_repository.dart';
import 'package:unipark_uitm_app/src/features/vehicle/models/vehicle_model.dart';
import 'package:unipark_uitm_app/src/features/vehicle/pages/vehicles_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class VehicleUpdateController extends GetxController {
  static VehicleUpdateController get instance => Get.find();

  VehicleUpdateController({
    required this.vehicle,
  });

  final brand = TextEditingController();
  final colour = TextEditingController();
  final model = TextEditingController();
  final ownerName = TextEditingController();
  final plateNumber = TextEditingController();
  final VehicleModel vehicle;
  final vehicleRepository = Get.put(VehicleRepository());
  GlobalKey<FormState> updateVehicleKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeVehicle();
    super.onInit();
  }

  Future<void> initializeVehicle() async {
    brand.text = vehicle.brand;
    colour.text = vehicle.colour;
    model.text = vehicle.model;
    ownerName.text = vehicle.ownerName;
    plateNumber.text = vehicle.plateNumber;
  }

  Future<void> updateVehicle() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!updateVehicleKey.currentState!.validate()) return;

      VehicleModel updateVehicle = VehicleModel(
        id: vehicle.id,
        brand: brand.text.trim(),
        colour: colour.text.trim(),
        model: model.text.trim(),
        ownerName: ownerName.text.trim(),
        plateNumber: plateNumber.text.toUpperCase().trim(),
        rfid: vehicle.rfid
      );
      await vehicleRepository.updateVehicleRecord(updateVehicle);

      vehicle.brand = brand.text.trim();
      vehicle.colour = colour.text.trim();
      vehicle.model = model.text.trim();
      vehicle.ownerName = ownerName.text.trim();
      vehicle.plateNumber = plateNumber.text.trim();

      SnackBarTheme.successSnackBar(title: 'Success', message: 'Your vehicle has been updated.');

      Get.off(() => const VehiclesPage());

    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> removeVehicle() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      await vehicleRepository.removeVehicleRecord(vehicle.id!);

      SnackBarTheme.successSnackBar(title: 'Success', message: 'Your vehicle has been deleted.');

      Get.off(() => const VehiclesPage());

    } catch (e) {
      // Show some Generic Error to the user
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}