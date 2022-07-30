import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistem_pakar_ayam/pages/controller.dart';

class TestHitung extends GetView<QueryController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => QueryController());
    return Scaffold(
      appBar: AppBar(
        title: Text("TestHitung"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => controller.filter(),
          child: Text(
            'Test Hitung',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
