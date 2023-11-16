import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/constants/colors.dart';
import 'package:unipark_uitm_app/src/constants/images.dart';
import 'package:unipark_uitm_app/src/constants/sizes.dart';
import 'package:unipark_uitm_app/src/features/authentication/presentation/pages/signin_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
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
                      const Gap(40.0),
                      Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: const AssetImage(uniparkLogo),
                          height: size.height * 0.08,
                        ),
                      ),
                      const Gap(35.0),
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Gap(10.0),
                      Text(
                        'Enter your personal information',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Name',
                        ),
                      ),
                      const Gap(10.0),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
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
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          hintText: '123456789',
                          prefixIcon: CountryCodePicker(
                            initialSelection: 'MY',
                            flagWidth: 30.0,
                          ),
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
                      const Gap(20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Register'),
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
                                children: const [
                                  TextSpan(text: "Sign In", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
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
