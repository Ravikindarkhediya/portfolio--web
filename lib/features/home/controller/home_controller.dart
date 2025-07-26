import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final isHovered = false.obs;
  final selectedSection = 'home'.obs;
  final scrollController = ScrollController();
  final hoveredIndex = (-1).obs;

  void setHoveredIndex(int index) => hoveredIndex.value = index;

  void onHoverEnter() => isHovered.value = true;
  void onHoverExit() => isHovered.value = false;

  void initScrollTracking({
    required List<GlobalKey> sectionKeys,
    required List<String> sectionIds,
  }) {
    scrollController.addListener(() {
      for (int i = 0; i < sectionKeys.length; i++) {
        final keyContext = sectionKeys[i].currentContext;
        if (keyContext != null) {
          final box = keyContext.findRenderObject() as RenderBox;
          final position = box.localToGlobal(Offset.zero).dy;

          if (position < 200 && position > -300) {
            selectedSection.value = sectionIds[i];
            break;
          }
        }
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
