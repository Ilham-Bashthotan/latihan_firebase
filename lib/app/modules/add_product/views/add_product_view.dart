import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: Padding(
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
              onPressed: () => controller.addProduct(
                controller.nameC.text,
                controller.priceC.text,
              ),
              child: const Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }
}
