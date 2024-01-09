import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/profile/controllers/update_studentid_controller.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/validators/validation.dart';
import 'package:unipark_uitm_app/src/utils/widgets/textformfield_widget.dart';

class UpdateStudentIdPage extends StatelessWidget {
  const UpdateStudentIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateStudentIdController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Form(
            key: controller.updateStudentIdFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Update your Student ID', style: Theme.of(context).textTheme.headlineSmall),
                const Gap(40.0),
                const Text('STUDENT ID', style: TextStyle(fontWeight: FontWeight.bold)),
                WTextFormField(
                  controller: controller.studentId,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) => Validations.validateStudentId(value),
                  hintText: '2022123456',
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
            onPressed: () => controller.updateStudentId(),
            child: const Text('Update'),
          ),
        ),
      ),
    );
  }
}
