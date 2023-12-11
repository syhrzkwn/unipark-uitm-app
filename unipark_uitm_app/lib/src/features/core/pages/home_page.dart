import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:unipark_uitm_app/src/features/authentication/controllers/logout_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogoutController());
    final dark = HelperFunction.isDarkMode(context);

    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: FloatingActionButton.extended(
          onPressed: () => controller.logout(),
          backgroundColor: dark ? textColor1 : whiteColor,
          icon: Icon(Bootstrap.car_front, color: dark ? whiteColor : Colors.black),
          label: Text('RFID', style: TextStyle(fontFamily: 'Epilogue', fontSize: 16, color: dark ? whiteColor : Colors.black)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: ColorfulSafeArea(
        color: Colors.transparent,
        overflowRules: const OverflowRules.all(true),
        child: SingleChildScrollView(
          child: Container(
          ),
        ),
      ),
    );
  }
}
