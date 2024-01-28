import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/inbox/controllers/inbox_controller.dart';
import 'package:unipark_uitm_app/src/features/inbox/model/inbox_model.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class InboxMessagePage extends StatelessWidget {
  const InboxMessagePage({
    super.key,
    required this.inbox,
  });

  final InboxModel inbox;

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(InboxController());
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) {
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: dark ? darkModeBackground : whiteColor,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () => notificationController.deleteSingleInbox(inboxId: inbox.id ?? ''),
                            child: const Text('Delete message', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.more_vert_outlined)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(inbox.inboxTitle ?? '', style: TextStyle(fontFamily: 'Epilogue', fontSize: 20.0, fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor)),
              const Gap(40.0),
              Text(inbox.inboxBody ?? ''),
              const Gap(20.0),
              Text(inbox.inboxDate),
            ],
          ),
        ),
      ),
    );
  }
}