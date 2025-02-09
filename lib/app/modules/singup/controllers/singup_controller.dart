import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingupController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC= TextEditingController();

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }
}
