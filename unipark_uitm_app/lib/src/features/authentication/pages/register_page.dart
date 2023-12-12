import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/features/authentication/controllers/register_controller.dart';
import 'package:unipark_uitm_app/src/features/authentication/controllers/signin_controller.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/signin_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:unipark_uitm_app/src/utils/validators/validation.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = HelperFunction.screenSize();
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      body: ColorfulSafeArea(
        color: Colors.transparent,
        overflowRules: const OverflowRules.all(true),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: size.height,
            ),
            child: Container(
              padding: const EdgeInsets.all(defaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Gap(37.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Register',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      const Gap(10.0),
                      Text(
                        'Enter your personal information',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const RegisterFormWidget(),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(() => const SigninPage());
                            },
                            child: Text.rich(
                              TextSpan(text: "Already have an account? ", style: Theme.of(context).textTheme.titleSmall,
                                children: [
                                  TextSpan(text: "Sign In", style: TextStyle(color: dark ? whiteColor : primaryColor, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final controller1 = Get.put(SignInController());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10.0),
      child: Form(
        key: controller.registerFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.name,
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validations.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Name',
              ),
            ),
            const Gap(10.0),
            TextFormField(
              controller: controller.studentId,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 10,
              validator: (value) => Validations.validateStudentId(value),
              decoration: const InputDecoration(
                counterText: '',
                labelText: 'Student ID',
                hintText: '2021234567',
              ),
            ),
            const Gap(10.0),
            TextFormField(
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validations.validateEmail(value),
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Email',
              ),
            ),
            const Gap(10.0),
            TextFormField(
              controller: controller.phone,
              keyboardType: TextInputType.phone,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 11,
              validator: (value) => Validations.validateEmptyText('Phone number', value),
              decoration: const InputDecoration(
                counterText: '',
                labelText: 'Phone',
                hintText: '0123456789',
              ),
            ),
            const Gap(10.0),
            Obx (
              () => TextFormField(
                controller: controller.password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => Validations.validatePassword(value),
                obscureText: controller.hidePassword.value,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Bootstrap.eye_slash : Bootstrap.eye),
                  ),
                ),
              ),
            ),
            const Gap(20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.registerUser(),
                child: const Text('Register'),
              ),
            ),
            const Gap(20.0),
            Text(
              'Or',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Gap(20.0),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: Logo(Logos.google, size:20.0),
                onPressed: () => controller1.googleSignIn(),
                label: const Text(
                  'Continue with Google',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}