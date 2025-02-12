import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_firebase/app/controllers/auth_controller.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocuments = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listAllDocuments.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () => Get.toNamed(
                  Routes.EDIT_PRODUCT,
                  arguments: listAllDocuments[index].id,
                ),
                title: Text(
                    '${(listAllDocuments[index].data() as Map<String, dynamic>)["name"]}'),
                subtitle: Text(
                    'Rp ${(listAllDocuments[index].data() as Map<String, dynamic>)["price"]}'),
                trailing: IconButton(
                  onPressed: () => controller.deleteData(listAllDocuments[index].id),
                  icon: const Icon(Icons.delete),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // one time get data
      // FutureBuilder<QuerySnapshot<Object?>>(
      //   future: controller.getData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       var listAllDocuments = snapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: listAllDocuments.length,
      //         itemBuilder: (context, index) => ListTile(
      //           title: Text('${(listAllDocuments[index].data() as Map<String, dynamic>)["name"]}'),
      //           subtitle: Text('Rp ${(listAllDocuments[index].data() as Map<String, dynamic>)["price"]}'),
      //         ),
      //       );
      //     }
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_PRODUCT),
        child: const Icon(Icons.add),
      ),
    );
  }
}
