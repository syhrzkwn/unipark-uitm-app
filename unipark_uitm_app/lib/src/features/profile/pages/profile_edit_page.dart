import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:unipark_uitm_app/src/features/core/controllers/user_controller.dart';
import 'package:unipark_uitm_app/src/features/profile/pages/delete_account_page.dart';
import 'package:unipark_uitm_app/src/features/profile/pages/update_name_page.dart';
import 'package:unipark_uitm_app/src/features/profile/pages/update_phone_page.dart';
import 'package:unipark_uitm_app/src/features/profile/pages/update_studentid_page.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/constants/sizes.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit profile', style: Theme.of(context).textTheme.headlineSmall),
              const Gap(40.0),
              const Text('FULL NAME', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(userController.user.value.name),
                trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                onTap: () {Get.to(() => const UpdateNamePage());},
              ),
              const Divider(color: borderColor),
              const Gap(20.0),
              const Text('STUDENT ID', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(userController.user.value.studentId.toString()),
                trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                onTap: () {Get.to(() => const UpdateStudentIdPage());},
              ),
              const Divider(color: borderColor),
              const Gap(20.0),
              const Text('PHONE NUMBER', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(userController.user.value.phone),
                trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14.0, color: dark ? whiteColor : textColor1),
                onTap: () {Get.to(() => const UpdatePhonePage());},
              ),
              const Divider(color: borderColor),
              const Gap(20.0),
              const Text('EMAIL ADDRESS', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text(userController.user.value.email),
                trailing: Icon(MingCute.lock_line, size: 20.0, color: dark ? whiteColor : textColor1),
                onTap: () {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You are not allowed to edit this field. Please contact support.')));},
              ),
              const Divider(color: borderColor),
              const Gap(40.0),
              Center(
                child: TextButton(
                  onPressed: () {Get.to(() => const DeleteAccountPage());},
                  child: const Text('DELETE ACCOUNT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
