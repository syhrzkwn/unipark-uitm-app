import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/core/controllers/user_controller.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/validators/validation.dart';

class ReSignInPage extends StatelessWidget {
  const ReSignInPage({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Form(
            key: controller.reSignInKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Re-Sign In', style: Theme.of(context).textTheme.headlineSmall),
                const Gap(10.0),
                Text("It's sad to see you go. By re-sign in to your UniPark@UiTM Account, you're confirm to delete your account", style: Theme.of(context).textTheme.titleSmall),
                const Gap(30.0),
                TextFormField(
                  controller: controller.verifyEmail,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => Validations.validateEmptyText('Email', value),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
                  ),
                ),
                const Gap(10.0),
                Obx (
                  () => TextFormField(
                    controller: controller.verifyPassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => Validations.validateEmptyText('Password', value),
                    obscureText: controller.hidePassword.value,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      ),
                    ),
                  ),
                ),
                const Gap(20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.reSignInUserWithEmailAndPassword(),
                    child: const Text('Verify'),
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
