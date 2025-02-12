import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addProduct(String name, String price) async {
    CollectionReference products = firestore.collection('products');

    try {
      String dateNow = DateTime.now().toIso8601String();
      await products.add({
        'name': name,
        'price': price,
        'date': dateNow,
      });
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to add product'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                nameC.clear();
                priceC.clear();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    Get.dialog(
      AlertDialog(
        title: const Text('Success'),
        content: const Text('Product added successfully'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    nameC = TextEditingController();
    priceC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    super.onClose();
  }
}
