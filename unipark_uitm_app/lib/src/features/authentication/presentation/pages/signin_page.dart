import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/constants/colors.dart';
import 'package:unipark_uitm_app/src/constants/images.dart';
import 'package:unipark_uitm_app/src/constants/sizes.dart';
import 'package:unipark_uitm_app/src/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:unipark_uitm_app/src/features/authentication/presentation/pages/register_page.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});
  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: ColorfulSafeArea(
        color: Colors.grey.withOpacity(0.7),
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
                          height: size.height * 0.08,
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
                  Column(
                    children: [
                      Form(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: formHeight - 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if(!_emailRegex.hasMatch(value)) {
                                    return 'Email is not valid';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Email',
                                ),
                              ),
                              const Gap(10.0),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Password',
                                  suffixIcon: IconButton(onPressed: null, icon: Icon(Icons.visibility)),
                                ),
                              ),
                              const Gap(10.0),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Get.to(() => const ForgotPasswordPage());
                                  },
                                  child: const Text(
                                    'Forgot password?',
                                    style: TextStyle(color: primaryColor, fontSize: 14.0, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const Gap(10.0),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Sign In'),
                                ),
                              ),
                              const Gap(25.0),
                              Text(
                                'or',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const Gap(25.0),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  icon: const Image(image: AssetImage(googleLogo), width:21.0),
                                  onPressed: () {},
                                  label: const Text(
                                      'Continue with Google',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                                children: const [
                                  TextSpan(text: "Register", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
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
