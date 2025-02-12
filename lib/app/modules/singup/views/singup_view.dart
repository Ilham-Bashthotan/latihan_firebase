import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_firebase/app/controllers/auth_controller.dart';

import '../controllers/singup_controller.dart';

class SingupView extends GetView<SingupController> {
  SingupView({super.key});

  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller.emailC,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: controller.passwordC,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => authC.singup(
                  controller.emailC.text, controller.passwordC.text),
              child: const Text('Signup'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah Punuya akun?'),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Login'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
