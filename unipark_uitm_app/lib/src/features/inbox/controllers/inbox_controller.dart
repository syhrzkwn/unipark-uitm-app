import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/authentication/authentication_repository.dart';
import 'package:unipark_uitm_app/src/data/repositories/inbox/inbox_repository.dart';
import 'package:unipark_uitm_app/src/features/inbox/model/inbox_model.dart';
import 'package:unipark_uitm_app/src/features/inbox/pages/inbox_page.dart';
import 'package:unipark_uitm_app/src/utils/theme/widget_themes/snackbar_theme.dart';

class InboxController extends GetxController {
  static InboxController get instance => Get.find();

  RxList<InboxModel> listInbox = <InboxModel>[].obs;

  @override
  void onInit() {
    fetchInbox();
    super.onInit();
  }

  void fetchInbox() {
    RxList<InboxModel> list = <InboxModel>[].obs;

    FirebaseFirestore.instance
    .collection("Users")
    .doc(AuthenticationRepository.instance.authUser!.uid)
    .collection("Inbox")
    .snapshots()
    .listen((QuerySnapshot<Map<String, dynamic>> event) {
      list.clear();
      for (var item in event.docs) {
        InboxModel inbox = InboxModel(
          id: item.id,
          inboxTitle: item.get('inbox_title'),
          inboxBody: item.get('inbox_body'),
          inboxDate: item.get('inbox_date'),
        );
        list.add(inbox);
      }
      listInbox.assignAll(list);
    });
  }

  Future<void> deleteSingleInbox({required String inboxId}) async {
    try {
      final inboxRepository = Get.put(InboxRepository());
      await inboxRepository.deleteSingleInbox(inboxId);

      SnackBarTheme.successSnackBar(title: 'Success', message: 'Your inbox has been deleted.');

      Get.off(() => const InboxPage());
    } catch (e) {
      SnackBarTheme.errorSnackBar(title: 'Error', message: 'Something went wrong. Please try again.');
    }
  }

  Future<void> deleteAllInbox() async {
    try {
      final inboxRepository = Get.put(InboxRepository());
      await inboxRepository.deleteAllInbox();

      SnackBarTheme.successSnackBar(title: 'Success', message: 'Your inbox has been deleted.');

    } catch (e) {
      SnackBarTheme.errorSnackBar(title: 'Error', message: 'Something went wrong. Please try again.');
    }
  }
}