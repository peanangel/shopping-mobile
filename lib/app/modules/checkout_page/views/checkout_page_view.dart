import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkout_page_controller.dart';

class CheckoutPageView extends GetView<CheckoutPageController> {
  const CheckoutPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckoutPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CheckoutPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
