import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/constants/images.dart';
import 'package:unipark_uitm_app/src/constants/sizes.dart';
import 'package:unipark_uitm_app/src/features/authentication/presentation/pages/register_page.dart';
import 'package:unipark_uitm_app/src/features/authentication/presentation/pages/signin_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ColorfulSafeArea(
        color: Colors.grey.withOpacity(0.7),
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Gap(80.0 - 25.0),
                  Image(
                    image: const AssetImage(uniparkLogo),
                    height: size.height * 0.08,
                  ),
                  const Gap(80.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'One app, all \nstudents needs',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const Gap(10.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'UiTM Parking Finder Mobile Application \nStart using UniPark@UiTM',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const SigninPage());
                      },
                      child: const Text('Sign In'),
                    ),
                  ),
                  const Gap(15.0),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.to(() => const RegisterPage());
                      },
                      style: OutlinedButton.styleFrom(),
                      child: const Text('Register'),
                    ),
                  ),
                  const Gap(25.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
