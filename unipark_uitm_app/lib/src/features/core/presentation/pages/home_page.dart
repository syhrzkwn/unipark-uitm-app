import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:unipark_uitm_app/src/constants/colors.dart';
import 'package:unipark_uitm_app/src/repository/authentication_repository/authentication_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: FloatingActionButton.extended(
          onPressed: (){
            AuthenticationRepository.instance.logout();
          },
          backgroundColor: whiteColor,
          icon: const Icon(Icons.directions_car_outlined, color: Colors.black),
          label: const Text('RFID', style: TextStyle(fontFamily: 'Epilogue', fontSize: 16, color: Colors.black)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: ColorfulSafeArea(
        color: Colors.grey.withOpacity(0.7),
        overflowRules: const OverflowRules.all(true),
        child: SingleChildScrollView(
          child: Container(
          ),
        ),
      ),
    );
  }
}
