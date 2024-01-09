import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/rfid/controllers/rfid_add_controller.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/validators/validation.dart';
import 'package:unipark_uitm_app/src/utils/widgets/textformfield_widget.dart';

class RFIDAddPage extends StatelessWidget {
  const RFIDAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RfidAddController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Form(
            key: controller.addRfidKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('RFID Activation', style: Theme.of(context).textTheme.headlineSmall),
                const Gap(10.0),
                Text('Please make sure you enter the correct information', style: Theme.of(context).textTheme.titleSmall),
                const Gap(40.0),
                const Text('RFID TAG ID', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.rfidTagId,
                  keyboardType: TextInputType.text,
                  validator: (value) => Validations.validateEmptyText('RFID Tag ID', value),
                  hintText: '01020304050607',
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const Gap(30.0),
                const Text('PLATE NUMBER', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.plateNumber,
                  keyboardType: TextInputType.text,
                  validator: (value) => Validations.validateEmptyText('Plate number', value),
                  hintText: 'ABC123',
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const Gap(30.0),
                const Text('OWNER NAME', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.ownerName,
                  keyboardType: TextInputType.text,
                  validator: (value) => Validations.validateEmptyText('Owner name', value),
                  hintText: 'Syahir Zakwan',
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const Gap(30.0),
                const Text('BRAND', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.vehicleBrand,
                  keyboardType: TextInputType.text,
                  validator: (value) => Validations.validateEmptyText('Brand', value),
                  hintText: 'Perodua',
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const Gap(30.0),
                const Text('MODEL', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.vehicleModel,
                  keyboardType: TextInputType.text,
                  validator: (value) => Validations.validateEmptyText('Model', value),
                  hintText: 'Myvi',
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const Gap(30.0),
                const Text('YEAR', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.vehicleYear,
                  keyboardType: TextInputType.text,
                  validator: (value) => Validations.validateEmptyText('Year', value),
                  hintText: '2024',
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(defaultSize),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.saveRfidInformation(),
            child: const Text('Activate RFID'),
          ),
        ),
      ),
    );
  }
}
