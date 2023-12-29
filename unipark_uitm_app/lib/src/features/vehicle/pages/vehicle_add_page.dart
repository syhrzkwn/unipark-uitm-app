import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/vehicle/controllers/vehicle_add_controller.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/validators/validation.dart';
import 'package:unipark_uitm_app/src/utils/widgets/textformfield_widget.dart';

class AddVehiclePage extends StatelessWidget {
  const AddVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VehicleAddController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Form(
            key: controller.addVehicleKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add new vehicle', style: Theme.of(context).textTheme.headlineSmall),
                const Gap(40.0),
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
                  hintText: 'Ali bin Abu',
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const Gap(30.0),
                const Text('BRAND', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.brand,
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
                  controller: controller.model,
                  keyboardType: TextInputType.text,
                  validator: (value) => Validations.validateEmptyText('Model', value),
                  hintText: 'Myvi',
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const Gap(30.0),
                const Text('COLOUR', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.colour,
                  keyboardType: TextInputType.text,
                  validator: (value) => Validations.validateEmptyText('Colour', value),
                  hintText: 'Black',
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const Gap(30.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.saveVehicleRecord(),
                    child: const Text('Add Vehicle'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
