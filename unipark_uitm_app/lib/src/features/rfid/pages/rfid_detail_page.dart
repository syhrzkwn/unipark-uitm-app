import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/rfid/controllers/rfid_controller.dart';
import 'package:unipark_uitm_app/src/features/rfid/models/rfid_model.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';

class RFIDDetailPage extends StatelessWidget {
  const RFIDDetailPage({
    super.key,
    required this.rfid,
  });

  final RfidModel rfid;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RfidController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('RFID Detail', style: Theme.of(context).textTheme.headlineSmall),
              const Gap(40.0),
              const Text('RFID TAG ID', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(rfid.rfidTagId),
              ),
              const Divider(color: borderColor),
              const Gap(20.0),
              const Text('RFID REGISTERED DATE', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(rfid.rfidRegisteredDate),
              ),
              const Divider(color: borderColor),
              const Gap(20.0),
              const Text('RFID EXPIRED DATE', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(rfid.rfidExpiredDate),
              ),
              const Divider(color: borderColor),
              const Gap(20.0),
              const Text('PLATE NUMBER', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(rfid.plateNumber),
              ),
              const Divider(color: borderColor),
              const Gap(20.0),
              const Text('OWNER NAME', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(rfid.ownerName),
              ),
              const Divider(color: borderColor),
              const Gap(20.0),
              const Text('VEHICLE BRAND', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(rfid.vehicleBrand),
              ),
              const Divider(color: borderColor),
              const Gap(20.0),
              const Text('VEHICLE MODEL', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(rfid.vehicleModel),
              ),
              const Divider(color: borderColor),
              const Gap(20.0),
              const Text('VEHICLE YEAR', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(rfid.vehicleYear),
              ),
              const Divider(color: borderColor),
              const Gap(40.0),
              Center(
                child: TextButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Terminate RFID', style: Theme.of(context).textTheme.headlineSmall,),
                      content: const Text("This operation can't be undone. Would you like to terminate this RFID tag?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('No', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () => controller.terminateRfid(id: rfid.id!),
                          child: const Text('Yes', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('TERMINATE RFID', style: TextStyle(fontWeight: FontWeight.bold, color: redColor)),
                ),
              ),
              const Gap(25.0),
            ],
          ),
        ),
      ),
    );
  }
}
