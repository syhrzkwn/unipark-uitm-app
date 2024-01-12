import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/rfid/models/rfid_model.dart';

class RfidRepository extends GetxController {
  static RfidRepository get instance => Get.find();
  
  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;

  Future<void> saveRfidRecord(RfidModel rfid) async {
    try {
      await _dbFirestore.collection("RFID").doc(rfid.id).set(rfid.toJson());
      // await _dbFirestore.collection("RFID").add(rfid.toJson());
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Future<List<RfidModel>> fetchActiveRfidRecord() async {
  //   try {
  //     final documentSnapshot = await _dbFirestore.collection("RFID").where("user_id", isEqualTo: AuthenticationRepository.instance.authUser?.uid).where("rfid_status", isEqualTo: true).get();
  //     return documentSnapshot.docs.map((e) => RfidModel.fromSnapshot(e)).toList();
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again.';
  //   }
  // }
  //
  // Future<List<RfidModel>> fetchTerminatedRfidRecord() async {
  //   try {
  //     final documentSnapshot = await _dbFirestore.collection("RFID").where("user_id", isEqualTo: AuthenticationRepository.instance.authUser?.uid).where("rfid_status", isEqualTo: false).get();
  //     return documentSnapshot.docs.map((e) => RfidModel.fromSnapshot(e)).toList();
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again.';
  //   }
  // }

  Future<void> updateSingleField({required Map<String, dynamic> json, required String id}) async {
    try {
      await _dbFirestore.collection("RFID").doc(id).update(json);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}