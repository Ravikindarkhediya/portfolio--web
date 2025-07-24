import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  var isLoading = false.obs;
  var submissionStatus = ''.obs;

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

      const serviceId = 'service_csjza2u';
      const templateId = 'template_g6dgt4p';
      const publicKey = 'BgMBtZMXrFk7_pkpd';

      const url = 'https://api.emailjs.com/api/v1.0/email/send';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'origin': 'http://localhost', // for Flutter Web
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': publicKey,
            'template_params': {
              'name': nameController.text,
              'email': emailController.text,
              'message': messageController.text,
            },
          }),
        );

        isLoading.value = false;

        if (response.statusCode == 200) {
          Get.snackbar("Success", "Message sent!",
              backgroundColor: Colors.green, colorText: Colors.white);

          nameController.clear();
          emailController.clear();
          messageController.clear();
          formKey.currentState!.reset();
        } else {
          Get.snackbar("Error", "Failed to send. Try again.",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Error", "An error occurred.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }
}