import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_firebase/app/services/network_services.dart';

class EditProductController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final networkService = Get.put(NetworkService());

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference products = firestore.collection('products').doc(id);
    return products.get();
  }

  void editProduct(String name, String price, String id) {
    DocumentReference documentData = firestore.collection('products').doc(id);

    try {
      String msg = '';
      documentData.update({
        'name': name,
        'price': price,
      });
      msg = networkService.isConnected.value
          ? 'Product edited successfully'
          : 'Product edited successfully, but you are offline';
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
