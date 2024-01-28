import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:unipark_uitm_app/src/features/parking/models/parking_model.dart';
import 'package:unipark_uitm_app/src/features/parking/pages/parking_detail_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class WParkingCard extends StatelessWidget {
  const WParkingCard({
    super.key,
    required this.parking,
  });

  final ParkingModel parking;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunction.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: GestureDetector(
        onTap: () {Get.to(() => ParkingDetailPage(parking: parking));},
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
                    Expanded(
                      child: Text(
                        parking.parkingName,
                        style: TextStyle(fontFamily: 'Epilogue', fontSize: 18.0, fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor),
                        maxLines: 2,
                      ),
                    ),
                    const Icon(Icons.more_horiz_outlined),
                  ],
                ),
                const Gap(5.0),
                Row(
                  children: [
                    Badge(label: parking.parkingStatus ? const Text('Open') : const Text('Close'), textColor: parking.parkingStatus ? activeGreenText : redColor, backgroundColor: parking.parkingStatus ? activeGreen : redColorBackground),
                    const Gap(5.0),
                    Badge(label: parking.parkingRfidStatus ? const Text('RFID') : Container(), textColor: parking.parkingRfidStatus ? primaryColor : Colors.transparent, backgroundColor: parking.parkingRfidStatus ? secondaryColor : Colors.transparent),
                  ],
                ),
                const Gap(20.0),
                Row(
                  children: [
                    Icon(MingCute.car_3_line, color: dark ? whiteColor : textColor1),
                    const Gap(5.0),
                    Text.rich(
                      TextSpan(text: "Parking Available: ",
                        children: [
                          TextSpan(text: parking.parkingRfidStatus ? "${parking.parkingTotal - parking.parkingAvailable}" : "not counted", style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
