import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController(text: "admin@gmail.com");
  TextEditingController passwordC = TextEditingController(text: "admin123");

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
