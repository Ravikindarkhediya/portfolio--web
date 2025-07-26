import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;

  const SectionContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: child,
    );
  }
}
