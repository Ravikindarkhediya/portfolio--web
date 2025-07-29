import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_portfolio/features/projects/projects_controller.dart';
import 'package:modern_portfolio/features/projects/widgets/project_card.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Ensure this import path is correct relative to your project structure
import '../../core/constants/app_constants.dart';

class ProjectsScreen extends StatelessWidget {
  ProjectsScreen({super.key});

  final ProjectsController controller = Get.put(ProjectsController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Projects',
                style: textTheme.displayLarge?.copyWith(fontSize: 32),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
              const SizedBox(height: AppConstants.defaultPadding),
              _buildFilterChips(context), // Pass context if needed by Theme.of
              const SizedBox(height: AppConstants.defaultPadding),
              Obx(() {
                if (controller.filteredProjects.isEmpty) {
                  return Center(
                    child: Text(
                      'No projects found for the selected filter.',
                      style: textTheme.bodyMedium,
                    ).paddingOnly(top: 50),
                  );
                }
                return ResponsiveGridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: ResponsiveGridDelegate(
                    maxCrossAxisExtent: 400,
                    minCrossAxisExtent:
                        ResponsiveValue<double>(
                          context,
                          defaultValue: 300.0,
                          conditionalValues: [],
                        ).value ??
                        300.0,
                    childAspectRatio:
                        ResponsiveValue<double>(
                          context,
                          defaultValue: 0.7,
                          conditionalValues: [],
                        ).value ??
                        0.8,
                    mainAxisSpacing: AppConstants.defaultPadding,
                    crossAxisSpacing: AppConstants.defaultPadding,
                  ),
                  itemCount: controller.filteredProjects.length,
                  itemBuilder: (context, index) {
                    final project = controller.filteredProjects[index];

                    return ProjectCard(
                          index: index,
                          project: project,
                          cardHeight: 450,
                          imageHeight: 240,
                          titleFontSize: 22,
                          spacing: 16,
                        )
                        .animate()
                        .fadeIn(delay: (200 + index * 100).ms)
                        .slideY(begin: 0.2, duration: 300.ms);
                  },
                );
              }),
              const SizedBox(height: AppConstants.sectionSpacing),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildFilterChips(BuildContext context) {
    // Added context parameter
    return Obx(
      () => Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: controller.selectedTag.value.isEmpty,
            onSelected: (selected) {
              if (selected) controller.filterByTag(null);
            },
            selectedColor: Theme.of(
              context,
            ).colorScheme.secondary.withOpacity(0.7),
            labelStyle: TextStyle(
              color:
                  controller.selectedTag.value.isEmpty
                      ? (Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white)
                      : null,
            ),
          ),
          ...controller.allTags.map(
            (tag) => ChoiceChip(
              // GetX provides a capitalizeFirst extension.
              label: Text(tag.capitalizeFirst ?? tag),
              selected: controller.selectedTag.value == tag,
              onSelected: (selected) {
                if (selected) controller.filterByTag(tag);
              },
              selectedColor: Theme.of(
                context,
              ).colorScheme.secondary.withOpacity(0.7),
              labelStyle: TextStyle(
                color:
                    controller.selectedTag.value == tag
                        ? (Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white) // Ensure contrast
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
