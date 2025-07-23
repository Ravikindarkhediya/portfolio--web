import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  var isLoading = false.obs;
  var submissionStatus = ''.obs; // 'success', 'error', or ''

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
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

  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your message';
    }
    if (value.length < 10) {
      return 'Message should be at least 10 characters';
    }
    return null;
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      submissionStatus.value = '';

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // In a real app, you'd send this data to a backend (e.g., Firebase Functions, Formspree)
      debugPrint('Name: ${nameController.text}');
      debugPrint('Email: ${emailController.text}');
      debugPrint('Message: ${messageController.text}');

      // Simulate success/failure
      bool success = true; // Change to false to test error

      if (success) {
        submissionStatus.value = 'success';
        Get.snackbar(
          'Success!',
          'Your message has been sent.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Optionally clear fields
        nameController.clear();
        emailController.clear();
        messageController.clear();
        formKey.currentState!.reset(); // Resets validation state
      } else {
        submissionStatus.value = 'error';
        Get.snackbar(
          'Error!',
          'Failed to send message. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      isLoading.value = false;
    }
  }
}