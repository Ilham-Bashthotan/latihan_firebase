import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference products = firestore.collection('products').doc(id);
    return products.get();
  }
  
  void editProduct(String name, String price, String id) async {
    DocumentReference documentData = firestore.collection('products').doc(id);

    try {
      await documentData.update({
        'name': name,
        'price': price,
      });
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to edit product'),
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
        content: const Text('Product edited successfully'),
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
