import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/widgets/rounded_card.dart';
import '../project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive adjustments
    final double imageHeight = screenWidth < 600 ? 140 : 200;
    final double spacing = screenWidth < 600 ? 10 : AppConstants.defaultPadding;
    final double chipFontSize = screenWidth < 600 ? 10 : 12;
    final double titleFontSize =
    screenWidth < 600 ? 16 : textTheme.titleLarge?.fontSize ?? 18;
    final double cardHeight = screenWidth < 600 ? 340 : 460;

    return RoundedCard(
      child: SizedBox(
        height: cardHeight,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConstants.cardBorderRadius),
                topRight: Radius.circular(AppConstants.cardBorderRadius),
              ),
              child: Image.asset(
                project.imageUrl,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: imageHeight,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(spacing),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spacing / 2),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: project.techStack.map((tech) {
                          return Chip(
                            label: Text(
                              tech,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.secondary,
                                fontSize: chipFontSize,
                              ),
                            ),
                            backgroundColor:
                            colorScheme.secondary.withOpacity(0.1),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (project.githubUrl != null)
                            ElevatedButton.icon(
                              icon: Icon(
                                Icons.visibility_outlined,
                                size: screenWidth < 600 ? 16 : 18,
                              ),
                              label: Text(
                                'Github',
                                style: TextStyle(
                                  fontSize: screenWidth < 600 ? 12 : null,
                                ),
                              ),
                              onPressed: () => launchURL(project.githubUrl!),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
