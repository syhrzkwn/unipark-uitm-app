import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/profile/controllers/update_phone_controller.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/validators/validation.dart';
import 'package:unipark_uitm_app/src/utils/widgets/textformfield_widget.dart';

class UpdatePhonePage extends StatelessWidget {
  const UpdatePhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Form(
            key: controller.updateUserPhoneFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Update your phone number', style: Theme.of(context).textTheme.headlineSmall),
                const Gap(40.0),
                const Text('PHONE NUMBER', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.phone,
                  keyboardType: TextInputType.phone,
                  maxLength: 15,
                  validator: (value) => Validations.validateEmptyText('Phone number', value),
                  hintText: '0123456789',
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
            onPressed: () => controller.updateUserPhone(),
            child: const Text('Update'),
          ),
        ),
      ),
    );
  }
}
