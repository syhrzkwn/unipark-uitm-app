import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/register_page.dart';
import 'package:unipark_uitm_app/src/features/authentication/pages/signin_page.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = HelperFunction.screenSize();
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      body: ColorfulSafeArea(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Gap(80.0 - 50.0),
                  Image(
                    image: const AssetImage(uniparkLogo),
                    height: size.height * 0.05,
                  ),
                  Image(
                    image: const AssetImage(welcome),
                    height: size.height * 0.4,
                  ),
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
                      'UiTM Parking Finder Mobile Application \nStart your journey with UniPark@UiTM',
                      style: Theme.of(context).textTheme.titleSmall,
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
                        Get.to(() => const RegisterPage());
                      },
                      child: const Text('Get Started'),
                    ),
                  ),
                  const Gap(15.0),
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
