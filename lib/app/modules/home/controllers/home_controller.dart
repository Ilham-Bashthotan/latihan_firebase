import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference products = firestore.collection('products');
    return products.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection('products');

    return products.orderBy("date", descending: true).snapshots();
  }

  void deleteData(String id) {
    DocumentReference products = firestore.collection('products').doc(id);

    try {
      Get.dialog(
        AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Are you sure to delete this data?'),
          actions: [
            OutlinedButton(
              onPressed: () async {
                Get.back();
              },
              child: const Text('Cancel'),
              style: TextButton.styleFrom(),
            ),
            ElevatedButton(
              onPressed: () async {
                await products.delete();
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to delete data',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
