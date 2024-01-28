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
import 'package:unipark_uitm_app/src/utils/widgets/textformfield_outline_widget.dart';

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
            WTextFormFieldOutline(
              controller: controller.name,
              keyboardType: TextInputType.text,
              obscureText: false,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) => Validations.validateEmptyText('Name', value),
              labelText: 'Name',
              hintText: 'Name',
            ),
            const Gap(10.0),
            WTextFormFieldOutline(
              controller: controller.studentId,
              keyboardType: TextInputType.number,
              obscureText: false,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) => Validations.validateStudentId(value),
              labelText: 'Student ID',
              hintText: '2021234567',
              maxLength: 10,
            ),
            const Gap(10.0),
            WTextFormFieldOutline(
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) => Validations.validateEmail(value),
              labelText: 'Email',
              hintText: 'Email',
            ),
            const Gap(10.0),
            WTextFormFieldOutline(
              controller: controller.phone,
              keyboardType: TextInputType.phone,
              obscureText: false,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) => Validations.validateEmptyText('Phone', value),
              labelText: 'Phone',
              hintText: '0123456789',
              maxLength: 11,
            ),
            const Gap(10.0),
            Obx(
              () => WTextFormFieldOutline(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                enableSuggestions: false,
                autocorrect: false,
                validator: (value) => Validations.validatePassword(value),
                labelText: 'Password',
                hintText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value ? MingCute.eye_close_line : MingCute.eye_2_line),
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
                icon: Brand(Brands.google, size:22.0),
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