import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../projects_controller.dart';

class FullScreenImageDialog extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FullScreenImageDialog({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  State<FullScreenImageDialog> createState() => _FullScreenImageDialogState();
}

class _FullScreenImageDialogState extends State<FullScreenImageDialog> {
  final CarouselSliderController _controller = CarouselSliderController();
  late final ProjectsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProjectsController>();
    controller.setFullScreenCarouselIndex(widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: _controller,
            itemCount: widget.imageUrls.length,
            options: CarouselOptions(
              initialPage: widget.initialIndex,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                controller.setFullScreenCarouselIndex(index);
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return Center(
                child: InteractiveViewer(
                  child: Image.asset(
                    widget.imageUrls[index],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),

          // ❌ Close Button
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // ⬅ Left Arrow Button
          Positioned(
            left: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: Obx(
                    () => Visibility(
                  visible: controller.fullScreenCarouselIndex.value > 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 32,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      _controller.previousPage();
                    },
                  ),
                ),
              ),
            ),
          ),

          // ➡ Right Arrow Button
          Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: Obx(
                    () => Visibility(
                  visible: controller.fullScreenCarouselIndex.value < widget.imageUrls.length - 1,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 32,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      _controller.nextPage();
                    },
                  ),
                ),
              ),
            ),
          ),

          // ✅ Image Index Indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Obx(
                  () => Center(
                child: Text(
                  '${controller.fullScreenCarouselIndex.value + 1} / ${widget.imageUrls.length}',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
