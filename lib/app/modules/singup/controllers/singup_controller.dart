import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingupController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC= TextEditingController();

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
