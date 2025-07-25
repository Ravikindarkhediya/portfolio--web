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
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final email = emailController.text.trim();
      final name = nameController.text.trim();
      final message = messageController.text.trim();

      try {
        // 1. Send OTP
        final otpResponse = await http.post(
          Uri.parse('http://192.168.2.208:4000/send-otp'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email}),
        );

        if (otpResponse.statusCode != 200) {
          isLoading.value = false;
          Get.snackbar('Error', 'Failed to send OTP',
              backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }

        final enteredOtp = await Get.dialog<String>(
          Builder(builder: (dialogContext) {
            int remainingSeconds = 120;
            Timer? timer;
            bool isExpired = false;
            String otpInput = '';

            final TextEditingController otpController = TextEditingController();
            final FocusNode focusNode = FocusNode();

            return StatefulBuilder(
              builder: (context, setState) {
                // Start timer only once
                timer ??= Timer.periodic(Duration(seconds: 1), (t) {
                  if (remainingSeconds == 0) {
                    t.cancel();
                    setState(() => isExpired = true);
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.of(dialogContext).pop();
                      Get.snackbar('OTP Expired', 'Please request a new OTP',
                          backgroundColor: Colors.orange, colorText: Colors.white);
                    });
                  } else {
                    setState(() => remainingSeconds--);
                  }
                });

                // Request focus when dialog appears
                Future.delayed(Duration(milliseconds: 100), () {
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
                          // If pasted or typed full 6-digit, auto-close
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
                      onPressed: isExpired || otpInput.length != 6
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
            );
          }),
        );


        // If user cancels or OTP expired
        if (enteredOtp == null) {
          isLoading.value = false;
          return;
        }

        // 3. Verify OTP
        final verifyResponse = await http.post(
          Uri.parse('http://192.168.2.208:4000/verify-otp'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'otp': enteredOtp}),
        );

        if (verifyResponse.statusCode != 200) {
          isLoading.value = false;
          Get.snackbar('Invalid OTP', 'Please try again',
              backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }

        // 4. Send actual message (after OTP success)
        final sendResponse = await http.post(
          Uri.parse('http://192.168.2.208:4000/send-email'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'name': name, 'email': email, 'message': message}),
        );

        isLoading.value = false;

        if (sendResponse.statusCode == 200) {
          Get.snackbar("Success", "Message sent!",
              backgroundColor: Colors.green, colorText: Colors.white);
          nameController.clear();
          emailController.clear();
          messageController.clear();
          formKey.currentState!.reset();
        } else {
          Get.snackbar('Error', 'Failed to send message',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'Something went wrong',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }


  // Future<String?> showOtpDialog(String email) async {
  //   final controller = TextEditingController();
  //   final focusNode = FocusNode();
  //   int seconds = 120;
  //   bool expired = false;
  //   Timer? timer;
  //
  //   return await Get.dialog<String>(
  //     StatefulBuilder(builder: (context, setState) {
  //       timer ??= Timer.periodic(const Duration(seconds: 1), (t) {
  //         if (seconds == 0) {
  //           t.cancel();
  //           setState(() => expired = true);
  //           Future.delayed(Duration(milliseconds: 500), () {
  //             Navigator.of(context).pop();
  //             Get.snackbar('OTP Expired', 'Please request again',
  //                 backgroundColor: Colors.orange, colorText: Colors.white);
  //           });
  //         } else {
  //           setState(() => seconds--);
  //         }
  //       });
  //
  //       Future.delayed(Duration(milliseconds: 300), () {
  //         if (!focusNode.hasFocus && !expired) focusNode.requestFocus();
  //       });
  //
  //       return AlertDialog(
  //         title: const Text("Enter OTP"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: controller,
  //               focusNode: focusNode,
  //               keyboardType: TextInputType.number,
  //               maxLength: 6,
  //               enabled: !expired,
  //               decoration: const InputDecoration(
  //                 hintText: "Enter 6-digit OTP",
  //                 counterText: '',
  //               ),
  //               onChanged: (val) {
  //                 final trimmed = val.trim();
  //                 if (trimmed.length == 6) {
  //                   timer?.cancel();
  //                   Navigator.of(context).pop(trimmed);
  //                 }
  //               },
  //             ),
  //             const SizedBox(height: 10),
  //             Text(
  //               expired
  //                   ? "OTP expired"
  //                   : "Expires in ${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}",
  //               style: TextStyle(
  //                 color: expired ? Colors.red : Colors.grey[700],
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               timer?.cancel();
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text("Cancel"),
  //           ),
  //         ],
  //       );
  //     }),
  //     barrierDismissible: false,
  //   );
  // }
}
