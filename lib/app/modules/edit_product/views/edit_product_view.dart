import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_product_controller.dart';

class EditProductView extends GetView<EditProductController> {
  const EditProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data!.data() as Map<String, dynamic>;
          controller.nameC.text = data['name'];
          controller.priceC.text = data['price'];
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.nameC,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Product Name',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.priceC,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => controller.editProduct(
                      controller.nameC.text,
                      controller.priceC.text,
                      Get.arguments,
                    ),
                    child: const Text('Edit Product'),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
