import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/formatter.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class InboxNotificationPage extends StatelessWidget {
  const InboxNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunction.isDarkMode(context);
    final message = Get.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {Get.back();},
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message.notification!.title.toString(), style: TextStyle(fontFamily: 'Epilogue', fontSize: 20.0, fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor)),
              const Gap(40.0),
              Text(message.notification!.body.toString()),
              const Gap(20.0),
              Text(Formatter.formatDateTime(DateTime.now())),
            ],
          ),
        ),
      ),
    );
  }
}