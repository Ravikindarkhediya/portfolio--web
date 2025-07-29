import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContactController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final isHoveredSubmit = false.obs;
  var isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }

  String? validateName(String? value) =>
      value == null || value.isEmpty ? 'Enter your name' : null;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Enter your email';
    if (!GetUtils.isEmail(value)) return 'Enter a valid email';
    return null;
  }

  String? validateMessage(String? value) =>
      value == null || value.length < 10 ? 'Min 10 characters' : null;

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final message = messageController.text.trim();

    try {
      final otpSent = await _sendOtp(email);
      if (!otpSent) return;

      final enteredOtp = await _showOtpDialog(Get.context!);
      if (enteredOtp == null) return;

      final otpVerified = await _verifyOtp(email, enteredOtp);
      if (!otpVerified) return;

      final messageSent = await _sendMessage(name, email, message);
      if (messageSent) _resetForm();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  //   todo: send otp
  Future<bool> _sendOtp(String email) async {
    final response = await http.post(
      Uri.parse('https://portfolio-transporter.onrender.com/send-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) return true;

    Get.snackbar(
      'Error',
      'Failed to send OTP',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return false;
  }

  //   todo: verify otp
  Future<bool> _verifyOtp(String email, String otp) async {
    final response = await http.post(
      Uri.parse('https://portfolio-transporter.onrender.com/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );

    if (response.statusCode == 200) return true;

    Get.snackbar(
      'Invalid OTP',
      'Please try again',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return false;
  }

  //   Todo: send message
  Future<bool> _sendMessage(String name, String email, String message) async {
    final response = await http.post(
      Uri.parse('https://portfolio-transporter.onrender.com/send-email'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'message': message}),
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        "Success",
        "Message sent!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      return true;
    }

    Get.snackbar(
      'Error',
      'Failed to send message',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return false;
  }

  //   todo: reset form
  void _resetForm() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
    formKey.currentState!.reset();
  }

  //   todo: show otp dialog
  Future<String?> _showOtpDialog(BuildContext dialogContext) async {
    int remainingSeconds = 120;
    Timer? timer;
    bool isExpired = false;
    String otpInput = '';

    final TextEditingController otpController = TextEditingController();
    final FocusNode focusNode = FocusNode();

    return await Get.dialog<String>(
      StatefulBuilder(
        builder: (context, setState) {
          // Start timer only once
          timer ??= Timer.periodic(const Duration(seconds: 1), (t) {
            if (remainingSeconds == 0) {
              t.cancel();
              setState(() => isExpired = true);
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(dialogContext).pop();
                Get.snackbar(
                  'OTP Expired',
                  'Please request a new OTP',
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
              });
            } else {
              setState(() => remainingSeconds--);
            }
          });

          // Request focus when dialog appears
          Future.delayed(const Duration(milliseconds: 100), () {
            if (!focusNode.hasFocus && !isExpired) {
              focusNode.requestFocus();
            }
          });

          return AlertDialog(
            title: const Text("Enter OTP"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: otpController,
                  focusNode: focusNode,
                  enabled: !isExpired,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    hintText: "Enter 6-digit OTP",
                    counterText: '',
                  ),
                  onChanged: (value) {
                    otpInput = value.trim();
                    if (otpInput.length == 6) {
                      timer?.cancel();
                      Navigator.of(dialogContext).pop(otpInput);
                    }
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  isExpired
                      ? "OTP expired"
                      : "Expires in ${remainingSeconds ~/ 60}:${(remainingSeconds % 60).toString().padLeft(2, '0')}",
                  style: TextStyle(
                    color: isExpired ? Colors.red : Colors.grey[700],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  timer?.cancel();
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed:
                    isExpired || otpInput.length != 6
                        ? null
                        : () {
                          timer?.cancel();
                          Navigator.of(dialogContext).pop(otpInput);
                        },
                child: const Text("Submit"),
              ),
            ],
          );
        },
      ),
      barrierDismissible: false,
    );
  }
}
