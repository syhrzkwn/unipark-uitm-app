import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/vehicle/models/vehicle_model.dart';
import 'package:unipark_uitm_app/src/data/repositories/vehicle/vehicle_repository.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class VehicleController extends GetxController {
  static VehicleController get instance => Get.find();

  RxList<VehicleModel> listVehicles = <VehicleModel>[].obs;
  Rx<VehicleModel> vehicle = VehicleModel.empty().obs;
  final vehicleRepository = Get.put(VehicleRepository());

  @override
  void onInit() {
    fetchVehicleInformation();
    super.onInit();
  }

  Future<void> fetchVehicleInformation() async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Fetch the data
      final vehicles = await vehicleRepository.fetchVehicleRecord();

      // Assign the data
      listVehicles.assignAll(vehicles);
    } catch (e) {
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}