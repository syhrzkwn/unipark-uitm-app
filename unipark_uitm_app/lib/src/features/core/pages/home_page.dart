import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unipark_uitm_app/src/features/core/pages/map_test.dart';
import 'package:unipark_uitm_app/src/utils/constants/colors.dart';
import 'package:unipark_uitm_app/src/utils/helpers/helper_functions.dart';
import 'package:unipark_uitm_app/src/features/authentication/controllers/logout_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const LatLng sourceLocation = LatLng(3.0698, 101.5037);
  static const LatLng destination = LatLng(3.0698, 101.5037);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogoutController());
    final dark = HelperFunction.isDarkMode(context);
    var size = HelperFunction.screenSize();

    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: FloatingActionButton.extended(
          onPressed: () => controller.logout(),
          // onPressed: () {Get.to(() => const MapSample());},
          backgroundColor: dark ? darkModeBackground : whiteColor,
          icon: Icon(Icons.directions_car_filled_outlined, color: dark ? whiteColor : textColor1),
          label: Text('RFID', style: TextStyle(fontSize: 16, color: dark ? whiteColor : textColor1)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: size.height,
        ),
        child: Container(color: primaryColor),
      ),
    );
  }
}
