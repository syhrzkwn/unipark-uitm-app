import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/features/authentication/controllers/signin_controller.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/forgot_password_page.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/register_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:unipark_uitm_app/src/utils/validators/validation.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(60.0),
                      Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: const AssetImage(uniparkLogo),
                          height: size.height * 0.07,
                        ),
                      ),
                      const Gap(60.0),
                      Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Gap(10.0),
                      Text(
                        'Sign in to start exploring parking inside UiTM',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SignInFormWidget(),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(() => const RegisterPage());
                            },
                            child: Text.rich(
                              TextSpan(text: "Don't have an account? ", style: Theme.of(context).textTheme.titleSmall,
                                children: [
                                  TextSpan(text: "Register", style: TextStyle(color: dark ? whiteColor : primaryColor, fontWeight: FontWeight.w600)),
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

class SignInFormWidget extends StatelessWidget {
  const SignInFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    final dark = HelperFunction.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10.0),
      child: Form(
        key: controller.signInFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller.email,
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
                controller: controller.password,
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
            const Gap(10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.to(() => const ForgotPasswordPage());
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: dark ? whiteColor : primaryColor, fontSize: 14.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const Gap(10.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signInUser(),
                child: const Text('Sign In'),
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
                onPressed: () => controller.googleSignIn(),
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
