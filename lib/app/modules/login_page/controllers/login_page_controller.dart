import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/app/routes/app_pages.dart';
import 'package:shopping/app/service/auth_service.dart';

class LoginPageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final rememberMe = false.obs;

  // สร้าง instance ของ AuthService
  final authService = AuthService();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void handleLogin() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      // เรียกใช้ authService.login เพื่อทำการล็อกอิน
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      bool loginSuccess = await authService.login(email, password);

      if (loginSuccess) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Future.delayed(Duration(seconds: 3), () {
          Get.offNamed(Routes.HOME);
        });
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Login failed. Please check your credentials.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
