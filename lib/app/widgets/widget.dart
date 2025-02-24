import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showMessage(String message, {bool isError = false}) {
  Get.snackbar(
    isError ? 'Error' : 'Success',
    message,
    backgroundColor: isError ? Colors.red : Colors.green,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    duration: Duration(seconds: 2),
  );
}
