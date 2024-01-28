import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/data/repositories/inbox/inbox_repository.dart';
import 'package:unipark_uitm_app/src/features/inbox/model/inbox_model.dart';
import 'package:unipark_uitm_app/src/features/inbox/pages/inbox_notification_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/formatter.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  // create an instance variable
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<void> initNotification() async {
    // request permission from user
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // initialize further settings for push notification
    initPushNotifications();
  }

  // function to handle received messages
  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;

    saveNotificationInbox(message);

    Get.to(() => const InboxNotificationPage(), arguments: message);
  }

  // function to save notification in database
  Future<void> saveNotificationInbox(RemoteMessage? message) async {
    if (message == null) return;

    DateTime currentDate = DateTime.now();
    String formattedCurrentDate = Formatter.formatDateTime(currentDate);

    final newInbox = InboxModel(
      inboxTitle: message.notification!.title,
      inboxBody: message.notification!.body,
      inboxDate: formattedCurrentDate,
    );

    final inboxRepository = Get.put(InboxRepository());
    await inboxRepository.saveInboxRecord(newInbox);
  }

  // function to initialize background settings
  Future initPushNotifications() async {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // subscribe compulsory notification topic
    _firebaseMessaging.subscribeToTopic('all');

    // handle notification if the app was terminated and now opened
    _firebaseMessaging.getInitialMessage().then(handleMessage);

    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen(handleMessage);
  }
}