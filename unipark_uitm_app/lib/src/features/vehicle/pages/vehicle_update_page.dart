import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/vehicle/controllers/vehicle_update_controller.dart';
import 'package:unipark_uitm_app/src/features/vehicle/models/vehicle_model.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/validators/validation.dart';
import 'package:unipark_uitm_app/src/utils/widgets/textformfield_widget.dart';

class VehicleUpdatePage extends StatelessWidget {
  const VehicleUpdatePage({
    super.key,
    required this.vehicle,
  });

  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    final vehicleUpdateController = Get.put(VehicleUpdateController(vehicle: vehicle));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Form(
            key: vehicleUpdateController.updateVehicleKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit vehicle', style: Theme.of(context).textTheme.headlineSmall),
                const Gap(40.0),
                const Text('PLATE NUMBER', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: vehicleUpdateController.plateNumber,
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
                  controller: vehicleUpdateController.ownerName,
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
                  controller: vehicleUpdateController.brand,
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
                  controller: vehicleUpdateController.model,
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
                  controller: vehicleUpdateController.colour,
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
                    onPressed: () => vehicleUpdateController.updateVehicle(),
                    child: const Text('Update'),
                  ),
                ),
                const Gap(30.0),
                Center(
                  child: TextButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text('Remove vehicle', style: Theme.of(context).textTheme.headlineSmall,),
                        content: const Text('Would you like to remove this vehicle?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () => vehicleUpdateController.removeVehicle(),
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    ),
                    child: const Text('REMOVE VEHICLE', style: TextStyle(fontWeight: FontWeight.bold, color: redColor)),
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
