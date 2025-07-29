import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

Future<void> launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    debugPrint('Could not launch $urlString');
  }
}