import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/repository/authentication_repository/authentication_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  //Call this function on register page ui
  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }
}