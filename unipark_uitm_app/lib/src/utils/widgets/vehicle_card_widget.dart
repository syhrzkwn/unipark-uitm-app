import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/vehicle/models/vehicle_model.dart';
import 'package:unipark_uitm_app/src/features/vehicle/pages/vehicle_update_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class WVehicleCard extends StatelessWidget {
  const WVehicleCard({
    super.key,
    required this.vehicle,
  });

  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => VehicleUpdatePage(vehicle: vehicle)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(vehicle.plateNumber, style: TextStyle(fontFamily: 'Epilogue', fontSize: 20.0, fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor)),
                  const Icon(Icons.more_horiz_outlined),
                ],
              ),
              const Gap(5.0),
              Text.rich(
                TextSpan(text: vehicle.colour,
                  children: [
                    const TextSpan(text: ' - '),
                    TextSpan(text: vehicle.brand),
                    const TextSpan(text: ' '),
                    TextSpan(text: vehicle.model),
                  ],
                ),
              ),
              const Gap(10.0),
              Badge(label: vehicle.rfid ? const Text('RFID') : const Text('No RFID'), textColor: vehicle.rfid ? primaryColor : redColor, backgroundColor: vehicle.rfid ? secondaryColor : redColorBackground),
            ],
          ),
        ),
      ),
    );
  }
}
