import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/inbox/controllers/inbox_controller.dart';
import 'package:unipark_uitm_app/src/features/inbox/pages/inbox_message_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:unipark_uitm_app/src/utils/widgets/inbox_listtile_widget.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(InboxController());
    var size = HelperFunction.screenSize();
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Obx(
            () {
              if (notificationController.listInbox.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.more_vert_outlined),
                );
              }
              return IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
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
                              onPressed: () => notificationController.deleteAllInbox(),
                              child: const Text('Delete all', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert_outlined)
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (notificationController.listInbox.isEmpty) {
                  return Text('Inbox', style: Theme.of(context).textTheme.headlineSmall);
                }
                return Row(
                  children: [
                    Text('Inbox', style: Theme.of(context).textTheme.headlineSmall),
                    const Gap(10.0),
                    Badge(label: Text('${notificationController.listInbox.length}'), textColor: whiteColor, backgroundColor: redColor),
                  ],
                );
              }),
              const Gap(10.0),
              const Divider(color: borderColor),
              const Gap(10.0),
              Obx(() {
                if(notificationController.listInbox.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        const Gap(50.0),
                        Image(
                          image: const AssetImage(emptyInbox),
                          height: size.height * 0.3,
                        ),
                        const Text('Your inbox is empty'),
                      ],
                    ),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: 90,
                    mainAxisSpacing: 0,
                  ),
                  itemCount: notificationController.listInbox.length,
                  itemBuilder: (_, index) => WInboxListTileWidget(
                    title: notificationController.listInbox[index].inboxTitle ?? '',
                    subTitle: notificationController.listInbox[index].inboxBody ?? '',
                    onTap: () { Get.to(() => InboxMessagePage(inbox: notificationController.listInbox[index],)); },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
