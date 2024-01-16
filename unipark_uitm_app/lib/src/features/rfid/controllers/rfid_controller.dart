import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/authentication/authentication_repository.dart';
import 'package:unipark_uitm_app/src/data/repositories/rfid/rfid_repository.dart';
import 'package:unipark_uitm_app/src/features/rfid/models/rfid_model.dart';
import 'package:unipark_uitm_app/src/features/rfid/pages/rfid_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class RfidController extends GetxController {
  static RfidController get instance => Get.find();

  final rfidRepository = Get.put(RfidRepository());
  RxList<RfidModel> listActiveRfid = <RfidModel>[].obs;
  RxList<RfidModel> listTerminatedRfid = <RfidModel>[].obs;

  @override
  void onInit() {
    // fetchRfidInformation();
    fetchRfidRealTime();
    super.onInit();
  }

  void fetchRfidRealTime() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      RxList<RfidModel> listARfid = <RfidModel>[].obs;
      RxList<RfidModel> listTRfid = <RfidModel>[].obs;

      FirebaseFirestore.instance
          .collection("RFID")
          .where("user_id", isEqualTo: AuthenticationRepository.instance.authUser!.uid)
          .where("rfid_status", isEqualTo: true)
          .snapshots()
          .listen((QuerySnapshot<Map<String, dynamic>> event) {
        listARfid.clear();
        for (var item in event.docs) {
          RfidModel rfid = RfidModel(
            id: item.id,
            userId: item.get('user_id'),
            ownerName: item.get('owner_name'),
            parkingEntered: item.get('parking_entered'),
            plateNumber: item.get('plate_number'),
            rfidTagId: item.get('rfid_tag_id'),
            rfidStatus: item.get('rfid_status'),
            rfidRegisteredDate: item.get('rfid_registered_date'),
            rfidExpiredDate: item.get('rfid_expired_date'),
            vehicleBrand: item.get('vehicle_brand'),
            vehicleModel: item.get('vehicle_model'),
            vehicleYear: item.get('vehicle_year'),
          );
          listARfid.add(rfid);
        }
        listActiveRfid.assignAll(listARfid);
      });

      FirebaseFirestore.instance
          .collection("RFID")
          .where("user_id", isEqualTo: AuthenticationRepository.instance.authUser!.uid)
          .where("rfid_status", isEqualTo: false)
          .snapshots()
          .listen((QuerySnapshot<Map<String, dynamic>> event) {
        listTRfid.clear();
        for (var item in event.docs) {
          RfidModel rfid = RfidModel(
            id: item.id,
            userId: item.get('user_id'),
            ownerName: item.get('owner_name'),
            parkingEntered: item.get('parking_entered'),
            plateNumber: item.get('plate_number'),
            rfidTagId: item.get('rfid_tag_id'),
            rfidStatus: item.get('rfid_status'),
            rfidRegisteredDate: item.get('rfid_registered_date'),
            rfidExpiredDate: item.get('rfid_expired_date'),
            vehicleBrand: item.get('vehicle_brand'),
            vehicleModel: item.get('vehicle_model'),
            vehicleYear: item.get('vehicle_year'),
          );
          listTRfid.add(rfid);
        }
        listTerminatedRfid.assignAll(listTRfid);
      });
    } catch (e) {
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  // void fetchRfidInformation() async {
  //   try {
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) return;
  //
  //     final activeRfids = await rfidRepository.fetchActiveRfidRecord();
  //     final terminatedRfids = await rfidRepository.fetchTerminatedRfidRecord();
  //
  //     listActiveRfid.assignAll(activeRfids);
  //     listTerminatedRfid.assignAll(terminatedRfids);
  //   } catch (e) {
  //     SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
  //   }
  // }

  void terminateRfid({required String id}) async {
    try {
      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Update the RFID status to false (terminated)
      Map<String, dynamic> updateRfidStatus = {'rfid_status': false};
      await rfidRepository.updateSingleField(json: updateRfidStatus, id: id);

      SnackBarTheme.successSnackBar(title: 'Success', message: 'Your RFID tag has been terminated.');

      Get.off(() => const RFIDPage());
    } catch (e) {
      SnackBarTheme.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}