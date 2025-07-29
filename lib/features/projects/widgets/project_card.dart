import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/widgets/rounded_card.dart';
import '../project_model.dart';
import '../projects_controller.dart';
import 'full_screen_image_dialog.dart';
import 'hoverable_chip.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final double cardHeight;
  final double imageHeight;
  final double titleFontSize;
  final double spacing;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.cardHeight,
    required this.imageHeight,
    required this.titleFontSize,
    required this.spacing,
    required this.index,
  });

  void _showFullImageDialog(BuildContext context, String imagePath) {
    // Your dialog code here
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectsController>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      final isHovered = controller.hoveredIndex.value == index;
      final isGithubHovered = controller.githubHoveredIndex.value == index;

      return MouseRegion(
        onEnter: (_) => controller.setHoveredIndex(index),
        onExit: (_) => controller.clearHoveredIndex(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: isHovered
              ? Matrix4.translationValues(0, -6, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            boxShadow: isHovered
                ? [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ]
                : [],
          ),
          child: RoundedCard(
            child: SizedBox(
              height: cardHeight,
              child: Column(
                children: [
                  // Carousel Slider for images
                  slider.CarouselSlider(
                    carouselController: controller.carouselController,
                    options: slider.CarouselOptions(
                      height: imageHeight,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        controller.onCarouselChanged(index);
                      },
                    ),
                    items: project.imageUrls.map((imagePath) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => FullScreenImageDialog(
                                imageUrls: project.imageUrls,
                                initialIndex: 0,
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(AppConstants.cardBorderRadius),
                              topRight: Radius.circular(AppConstants.cardBorderRadius),
                            ),
                            child: Image.asset(
                              imagePath,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(project.imageUrls.length, (index) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentCarouselIndex.value == index
                                ? colorScheme.primary
                                : Colors.grey.shade400,
                          ),
                        );
                      }),
                    );
                  }),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(spacing),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: titleFontSize,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spacing / 2),
                            Text(
                              project.description,
                              style: textTheme.bodyMedium,
                              maxLines: 10,
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(height: spacing),
                            Text(
                              'Tech Stack:',
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: spacing / 2),
                            Wrap(
                              spacing: 6.0,
                              runSpacing: 6.0,
                              children:
                              project.techStack.map((tech) {
                                return HoverableChip(
                                  label: tech,
                                  baseColor: colorScheme.secondary,
                                  textStyle: textTheme.bodySmall!,
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spacing),
                            if (project.githubUrl != null)
                              MouseRegion(
                                onEnter:
                                    (_) =>
                                    controller.setGithubHoveredIndex(index),
                                onExit:
                                    (_) => controller.clearGithubHoveredIndex(),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    isGithubHovered
                                        ? colorScheme.secondary.withOpacity(
                                      0.2,
                                    )
                                        : colorScheme.primary,
                                    foregroundColor:
                                    isGithubHovered
                                        ? Colors.black
                                        : Colors.white,
                                    elevation: isGithubHovered ? 6 : 2,
                                  ),
                                  icon: Icon(
                                    Icons.visibility_outlined,
                                    color:
                                    isGithubHovered
                                        ? Colors.black
                                        : Colors.white,
                                    size: screenWidth < 600 ? 16 : 18,
                                  ),
                                  label: Text(
                                    'Github',
                                    style: TextStyle(
                                      fontSize: screenWidth < 600 ? 12 : null,
                                      color:
                                      isGithubHovered
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  onPressed:
                                      () => launchURL(project.githubUrl!),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
