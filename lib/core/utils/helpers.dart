import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

Future<void> launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    // Consider showing a snackbar or dialog on failure
    debugPrint('Could not launch $urlString');
  }
}