import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/features/core/controllers/user_controller.dart';
import 'package:unipark_uitm_app/src/features/profile/pages/profile_edit_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:unipark_uitm_app/src/features/authentication/controllers/logout_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(LogoutController());
    final userController = Get.put(UserController());
    final dark = HelperFunction.isDarkMode(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30.0),
                Obx(() => Text(userController.user.value.name, style: Theme.of(context).textTheme.headlineSmall)),
                const Gap(50.0),
                Text('Account', style: TextStyle(fontFamily: 'Epilogue', fontSize: 20.0, fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor)),
                const Gap(10.0),
                const Divider(color: borderColor),
                ListTile(
                  leading: Icon(Icons.person_outline_outlined, color: dark ? whiteColor : textColor1),
                  title: const Text('Personal information'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                  onTap: () {Get.to(() => const ProfileEditPage());},
                ),
                const Divider(color: borderColor, indent: 70.0),
                ListTile(
                  leading: Icon(Icons.directions_car_filled_outlined, color: dark ? whiteColor : textColor1),
                  title: const Text('My vehicles'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                  onTap: () {},
                ),
                const Divider(color: borderColor, indent: 70.0),
                ListTile(
                  leading: Icon(Icons.qr_code_scanner_outlined, color: dark ? whiteColor : textColor1),
                  title: const Text('RFID'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                  onTap: () {},
                ),
                const Divider(color: borderColor, indent: 70.0),
                const Gap(30.0),
                Text('Setting', style: TextStyle(fontFamily: 'Epilogue', fontSize: 20.0, fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor)),
                const Gap(10.0),
                const Divider(color: borderColor),
                ListTile(
                  leading: Icon(Icons.dark_mode_outlined, color: dark ? whiteColor : textColor1),
                  title: const Text('Theme'),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {}
                  ),
                ),
                const Divider(color: borderColor, indent: 70.0),
                const Gap(50.0),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () => authController.logout(),
                        child: const Text('LOG OUT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                      ),
                      const Gap(10.0),
                      const Text('UniPark@UiTM 1.0.0(1)', style: TextStyle(fontSize: 12.0, color: textColor2)),
                    ],
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
