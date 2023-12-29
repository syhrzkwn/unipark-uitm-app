import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/profile/controllers/update_name_controller.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/validators/validation.dart';
import 'package:unipark_uitm_app/src/utils/widgets/textformfield_widget.dart';

class UpdateNamePage extends StatelessWidget {
  const UpdateNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Form(
            key: controller.updateUserNameFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Update your full name', style: Theme.of(context).textTheme.headlineSmall),
                const Gap(40.0),
                const Text('FULL NAME', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.name,
                  keyboardType: TextInputType.name,
                  validator: (value) => Validations.validateEmptyText('Name', value),
                  hintText: 'Ali bin Abu',
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const Gap(30.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.updateUserName(),
                    child: const Text('Update'),
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
