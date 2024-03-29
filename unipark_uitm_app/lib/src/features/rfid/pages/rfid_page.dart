import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/rfid/controllers/rfid_controller.dart';
import 'package:unipark_uitm_app/src/features/rfid/pages/rfid_add_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:unipark_uitm_app/src/utils/widgets/rfid_card.dart';

class RFIDPage extends StatelessWidget {
  const RFIDPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final rfidController = Get.put(RfidController());
    var size = HelperFunction.screenSize();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () { Get.to(()=> const RFIDAddPage()); },
        child: const Icon(Icons.add, color: whiteColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('RFID', style: Theme.of(context).textTheme.headlineSmall),
              const Gap(40.0),
              Obx(() {
                if(rfidController.listActiveRfid.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        const Gap(50.0),
                        Image(
                          image: const AssetImage(noRfid),
                          height: size.height * 0.3,
                        ),
                        const Text('No active RFID found. Please activate new RFID'),
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
                    mainAxisExtent: 145,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: rfidController.listActiveRfid.length,
                  itemBuilder: (_, index) => WRFIDCard(rfid: rfidController.listActiveRfid[index]),
                );
              }),
              Obx(() {
                if(rfidController.listTerminatedRfid.isEmpty) {
                  return Container();
                }
                return Column(
                  children: [
                    const Gap(20.0),
                    const Divider(color: borderColor),
                    const Gap(20.0),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisExtent: 145,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: rfidController.listTerminatedRfid.length,
                      itemBuilder: (_, index) => WRFIDCard(rfid: rfidController.listTerminatedRfid[index]),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
