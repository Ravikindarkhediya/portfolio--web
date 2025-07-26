import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'about_controller.dart';

class AboutCard extends StatelessWidget {
  final String id;
  final Widget child;

  AboutCard({super.key, required this.id, required this.child});

  final hoverController = Get.find<AboutController>();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => hoverController.setHover(id, true),
      onExit: (_) => hoverController.setHover(id, false),
      child: Obx(() {
        final isHovered = hoverController.isHovering(id).value;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform:
              isHovered
                  ? (Matrix4.identity()
                    ..translate(0.0, -4.0)
                    ..scale(1.02))
                  : Matrix4.identity(),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow:
                isHovered
                    ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: const Offset(0, 10),
                        blurRadius: 25,
                      ),
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        offset: const Offset(0, 5),
                        blurRadius: 15,
                      ),
                    ]
                    : [],
          ),
          padding: const EdgeInsets.all(24),
          child: child,
        );
      }),
    );
  }
}
