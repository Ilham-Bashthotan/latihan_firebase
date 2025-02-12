import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_firebase/app/services/network_services.dart';

class AddProductController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final networkService = Get.put(NetworkService());

  void addProduct(String name, String price) {
    CollectionReference products = firestore.collection('products');

    try {
      String dateNow = DateTime.now().toIso8601String();
      products.add({
        'name': name,
        'price': price,
        'date': dateNow,
      });
      String msg = networkService.isConnected.value
          ? 'Product added successfully'
          : 'Product added successfully, but you are offline';
      Get.dialog(
        AlertDialog(
          title: const Text('Success'),
          content: Text(msg),
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
