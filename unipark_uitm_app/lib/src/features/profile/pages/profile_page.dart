import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:unipark_uitm_app/src/features/core/controllers/user_controller.dart';
import 'package:unipark_uitm_app/src/features/profile/controllers/profile_controller.dart';
import 'package:unipark_uitm_app/src/features/profile/pages/profile_edit_page.dart';
import 'package:unipark_uitm_app/src/features/rfid/pages/rfid_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/constants/images.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:unipark_uitm_app/src/features/authentication/controllers/logout_controller.dart';
import 'package:unipark_uitm_app/src/utils/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(LogoutController());
    final userController = Get.put(UserController());
    final profileController = Get.put(ProfileController());
    final dark = HelperFunction.isDarkMode(context);
    var size = HelperFunction.screenSize();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(50.0),
                Obx(() => Text(userController.user.value.name, style: Theme.of(context).textTheme.headlineSmall)),
                const Gap(10.0),
                Obx(
                  () => Row(
                    children: [
                      Text('${userController.user.value.studentId} | Student'),
                      const Gap(5.0),
                      const Icon(Icons.verified, size: 16.0, color: activeGreenText,)
                    ],
                  ),
                ),
                const Gap(40.0),
                Text('Account', style: TextStyle(fontFamily: 'Epilogue', fontSize: 20.0, fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor)),
                const Gap(10.0),
                const Divider(color: borderColor),
                ListTile(
                  leading: Icon(MingCute.user_3_line, color: dark ? whiteColor : textColor1),
                  title: const Text('Personal information'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                  onTap: () {Get.to(() => const ProfileEditPage());},
                ),
                const Divider(color: borderColor, indent: 70.0),
                ListTile(
                  leading: Icon(Icons.nfc_outlined, color: dark ? whiteColor : textColor1),
                  title: const Text('RFID'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                  onTap: () {Get.to(() => const RFIDPage());},
                ),
                const Divider(color: borderColor, indent: 70.0),
                const Gap(30.0),

                Text('Settings', style: TextStyle(fontFamily: 'Epilogue', fontSize: 20.0, fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor)),
                const Gap(10.0),
                const Divider(color: borderColor),
                ListTile(
                  leading: Icon(MingCute.location_2_line, color: dark ? whiteColor : textColor1),
                  title: const Text('Location'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                  onTap: () => AppSettings.openAppSettings(type: AppSettingsType.location),
                ),
                const Divider(color: borderColor, indent: 70.0),
                ListTile(
                  leading: Icon(MingCute.notification_line, color: dark ? whiteColor : textColor1),
                  title: const Text('Notification'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                  onTap: () => AppSettings.openAppSettings(type: AppSettingsType.notification),
                ),
                const Divider(color: borderColor, indent: 70.0),
                ListTile(
                  leading: Icon(dark ? MingCute.moon_line : MingCute.sun_line, color: dark ? whiteColor : textColor1),
                  title: const Text('Theme'),
                  trailing: Obx(
                        () => Switch(
                      activeColor: primaryColor,
                      inactiveThumbColor: primaryColor,
                      inactiveTrackColor: secondaryColor,
                      value: profileController.switchTheme.value,
                      onChanged: (value) {
                        profileController.switchTheme.value = !profileController.switchTheme.value;
                        profileController.switchTheme.value ? Get.changeTheme(AppTheme.darkTheme) : Get.changeTheme(AppTheme.lightTheme);
                      },
                    ),
                  ),
                ),
                const Divider(color: borderColor, indent: 70.0),
                const Gap(30.0),

                Text('Support', style: TextStyle(fontFamily: 'Epilogue', fontSize: 20.0, fontWeight: FontWeight.bold, color: dark ? whiteColor : blackColor)),
                const Gap(10.0),
                const Divider(color: borderColor),
                ListTile(
                  leading: Icon(MingCute.information_line, color: dark ? whiteColor : textColor1),
                  title: const Text('About'),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: profileController.appInfo.value.appName,
                      applicationVersion: '${profileController.appInfo.value.version} (${profileController.appInfo.value.buildNumber})',
                      applicationLegalese: 'UniPark@UiTM: UiTM Parking Finder Mobile Application\n\n© ${DateTime.now().year} syhrzkwn.dev',
                      applicationIcon: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Image(
                          image: const AssetImage(uniparkLogo),
                          height: size.height * 0.05,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(color: borderColor, indent: 70.0),
                const Gap(30.0),

                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () => authController.logout(),
                        child: const Text('LOG OUT', style: TextStyle(fontWeight: FontWeight.bold, color: redColor)),
                      ),
                      const Gap(10.0),
                      Obx(
                        () => Text('${profileController.appInfo.value.appName} ${profileController.appInfo.value.version} (${profileController.appInfo.value.buildNumber})', style: const TextStyle(fontSize: 12.0, color: textColor2)),
                      ),
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
