import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:unipark_uitm_app/src/features/authentication/controllers/forgot_password_controller.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/signin_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    var size = HelperFunction.screenSize();
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(Icons.close_outlined),
          onTap: () {
            Get.offAll(() => const SigninPage());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(defaultSize, 0.0, defaultSize, defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image(
                  image: const AssetImage(resetPassword),
                  height: size.height * 0.4,
                ),
              ),
              Text(
                'Password Reset Email Sent',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Gap(15.0),
              Text(
                email,
                style: TextStyle(color: dark ? whiteColor : blackColor, fontWeight: FontWeight.w600),
              ),
              const Gap(15.0),
              Text(
                "Your account security is our priority! We've sent you a secure link to safely reset your password and keep your account protected",
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
              const Gap(30.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => const SigninPage());
                  },
                  child: const Text('Done'),
                ),
              ),
              const Gap(15.0),
              TextButton(
                onPressed: () => ForgotPasswordController.instance.resendEmailResetPassword(email),
                child: Text(
                  'Resend Email',
                  style: TextStyle(color: dark ? whiteColor : textColor1, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}