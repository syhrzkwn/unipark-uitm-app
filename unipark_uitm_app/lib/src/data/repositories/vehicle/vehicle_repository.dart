import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/authentication/authentication_repository.dart';
import 'package:unipark_uitm_app/src/features/vehicle/models/vehicle_model.dart';

class VehicleRepository extends GetxController {
  static VehicleRepository get instance => Get.find();

  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;

  Future<void> saveVehicleRecord(VehicleModel vehicle) async {
    try {
      await _dbFirestore.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).collection("Vehicles").add(vehicle.toJson());
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<List<VehicleModel>> fetchVehicleRecord() async {
    try {
      final documentSnapshot = await _dbFirestore.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).collection("Vehicles").get();
      return documentSnapshot.docs.map((e) => VehicleModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> updateVehicleRecord(VehicleModel updateVehicle) async {
    try {
      await _dbFirestore.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).collection("Vehicles").doc(updateVehicle.id).update(updateVehicle.toJson());
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> removeVehicleRecord(String vehicleId) async {
    try {
      await _dbFirestore.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).collection("Vehicles").doc(vehicleId).delete();
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}