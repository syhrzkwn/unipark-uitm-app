import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/rfid/models/rfid_model.dart';
import 'package:unipark_uitm_app/src/features/rfid/pages/rfid_detail_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class WRFIDCard extends StatelessWidget {
  const WRFIDCard({
    super.key,
    required this.rfid,
  });

  final RfidModel rfid;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        rfid.rfidStatus ? Get.to(() => RFIDDetailPage(rfid: rfid)) : {};
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: dark ? textColor1 : borderColor, width: 1),
        ),
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(rfid.plateNumber, style: TextStyle(fontFamily: 'Epilogue', fontSize: 20.0, fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor)),
                  const Icon(Icons.more_horiz_outlined),
                ],
              ),
              const Gap(5.0),
              Text('${rfid.vehicleBrand} ${rfid.vehicleModel} (${rfid.vehicleYear})'),
              const Gap(5.0),
              Text('Tag ID - ${rfid.rfidTagId}'),
              const Gap(10.0),
              Badge(label: rfid.rfidStatus ? const Text('Active') : const Text('Terminated'), textColor: rfid.rfidStatus ? activeGreenText : redColor, backgroundColor: rfid.rfidStatus ? activeGreen : redColorBackground),
            ],
          ),
        ),
      ),
    );
  }
}
