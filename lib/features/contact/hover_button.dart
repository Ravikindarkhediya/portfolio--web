import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

class HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const HoverButton({super.key, required this.onPressed, required this.isLoading});

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.send_outlined),
          label: const Text('Send Message'),
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            elevation: isHovered ? 10 : 4,
            backgroundColor: isHovered ? color.primary.withOpacity(0.9) : color.primary,
            padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: Colors.black.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
