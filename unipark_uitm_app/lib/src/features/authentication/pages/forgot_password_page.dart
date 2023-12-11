import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/verification_code_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');

  @override
  Widget build(BuildContext context) {
    var size = HelperFunction.screenSize();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(defaultSize, 0.0, defaultSize, defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                  image: const AssetImage(forgotPassword),
                  height: size.height * 0.3,
                ),
              ),
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gap(10.0),
              Text(
                "Enter the email address you used when you joined and we'll send a verification code to reset your password",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(30.0),
              TextFormField(
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
              const Gap(20.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const VerificationCodePage());
                  },
                  child: const Text('Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
