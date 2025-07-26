import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/widgets/rounded_card.dart';
import '../project_model.dart';
import 'hoverable_chip.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;
  bool isGithubHovered = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    final double imageHeight = screenWidth < 600 ? 140 : 200;
    final double spacing = screenWidth < 600 ? 10 : AppConstants.defaultPadding;
    final double chipFontSize = screenWidth < 600 ? 10 : 12;
    final double titleFontSize =
        screenWidth < 600 ? 16 : textTheme.titleLarge?.fontSize ?? 18;
    final double cardHeight = screenWidth < 600 ? 340 : 460;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform:
            isHovered
                ? Matrix4.translationValues(0, -6, 0)
                : Matrix4.identity(),
        decoration: BoxDecoration(
          boxShadow:
              isHovered
                  ? [
                     BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
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
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppConstants.cardBorderRadius),
                    topRight: Radius.circular(AppConstants.cardBorderRadius),
                  ),
                  child: Image.asset(
                    widget.project.imageUrl,
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
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
                            widget.project.title,
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: titleFontSize,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spacing / 2),
                          Text(
                            widget.project.description,
                            style: textTheme.bodyMedium,
                            maxLines: 10,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(height: spacing),
                          Text(
                            'Tech Stack:',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20
                            ),
                          ),
                          SizedBox(height: spacing / 2),
                          Wrap(
                            spacing: 6.0,
                            runSpacing: 6.0,
                            children: widget.project.techStack.map((tech) {
                              return HoverableChip(
                                label: tech,
                                baseColor: colorScheme.secondary,
                                textStyle: textTheme.bodySmall!,
                              );
                            }).toList(),
                          ),
                          SizedBox(height: spacing),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (widget.project.githubUrl != null)
                                MouseRegion(
                                  onEnter:
                                      (_) => setState(
                                        () => isGithubHovered = true,
                                      ),
                                  onExit:
                                      (_) => setState(
                                        () => isGithubHovered = false,
                                      ),
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isGithubHovered
                                          ? colorScheme.secondary.withOpacity(0.2)
                                          : colorScheme.primary,
                                      foregroundColor: isGithubHovered ? Colors.black : Colors.white,
                                      elevation: isGithubHovered ? 6 : 2,
                                    ),
                                    icon: Icon(
                                      Icons.visibility_outlined,
                                      color: isGithubHovered ? Colors.black : Colors.white,
                                      size: screenWidth < 600 ? 16 : 18,
                                    ),
                                    label: Text(
                                      'Github',
                                      style: TextStyle(
                                        fontSize: screenWidth < 600 ? 12 : null,
                                        color: isGithubHovered ? Colors.black : Colors.white,
                                      ),
                                    ),

                                    onPressed:
                                        () => launchURL(
                                          widget.project.githubUrl!,
                                        ),
                                  ),
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
        ),
      ),
    );
  }
}
