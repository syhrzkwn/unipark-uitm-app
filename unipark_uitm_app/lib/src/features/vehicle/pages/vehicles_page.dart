import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/vehicle/controllers/vehicle_controller.dart';
import 'package:unipark_uitm_app/src/features/vehicle/pages/vehicle_add_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/widgets/gridview_widget.dart';
import 'package:unipark_uitm_app/src/utils/widgets/vehicle_card_widget.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VehicleController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          Get.to(() => const AddVehiclePage());
        },
        child: const Icon(Icons.add, color: whiteColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My vehicles', style: Theme.of(context).textTheme.headlineSmall),
              const Gap(40.0),

              Obx(() {
                if(controller.listVehicles.isEmpty) {
                  return const Center(child: Text('No vehicles found. Please add new vehicle.'));
                }
                return WGridView(itemCount: controller.listVehicles.length, itemBuilder: (_, index) => WVehicleCard(vehicle: controller.listVehicles[index]));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
