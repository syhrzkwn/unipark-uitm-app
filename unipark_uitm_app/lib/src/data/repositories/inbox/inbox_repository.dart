import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/authentication/authentication_repository.dart';
import 'package:unipark_uitm_app/src/features/inbox/model/inbox_model.dart';

class InboxRepository extends GetxController {
  static InboxRepository get instance => Get.find();

  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;

  Future<void> saveInboxRecord(InboxModel inbox) async {
    try {
      await _dbFirestore.collection("Users").doc(AuthenticationRepository.instance.authUser!.uid).collection("Inbox").doc(inbox.id).set(inbox.toJson());
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> deleteSingleInbox(String inboxId) async {
    try {
      await _dbFirestore.collection("Users").doc(AuthenticationRepository.instance.authUser!.uid).collection("Inbox").doc(inboxId).delete();
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> deleteAllInbox() async {
    try {
      var collection = _dbFirestore.collection("Users").doc(AuthenticationRepository.instance.authUser!.uid).collection("Inbox");
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}