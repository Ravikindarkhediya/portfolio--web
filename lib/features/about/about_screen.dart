import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:modern_portfolio/features/about/widgets/about_card.dart';
import 'package:modern_portfolio/features/about/widgets/expandable_info_card.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> experiences = [
      {
        'title': 'Flutter Developer',
        'subtitle': 'CreativeInfoWay | May 2025 - Ongoing',
        'description':
        'Developed and maintained features for various client projects using Flutter and Dart. Collaborated with UI/UX designers.',
      },
    ];

    final List<Map<String, String>> educations = [
      {
        'title': 'Bachelor Computer of Science',
        'subtitle': 'Bhakta Kavi Narsinh Mehta University | 2024',
        'description':
        'Developed applications and websites while learning various programming languages.',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// About Title
              Text(
                'About Me',
                style: textTheme.displayLarge?.copyWith(fontSize: 32),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),

              const SizedBox(height: AppConstants.defaultPadding),

              /// Bio Card
              AboutCard(
                id: '',
                child: Text(
                  AppStrings.bio,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    height: 1.6,
                    shadows: [
                      Shadow(
                        color: isDark ? Colors.white24 : Colors.purple.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 2,
                      ),
                      Shadow(
                        color: isDark ? Colors.purple.withOpacity(0.3) : Colors.white24,
                        offset: const Offset(-1, -1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.sectionSpacing),

              /// Experience Section
              Text(
                'Experience',
                style: textTheme.displayLarge?.copyWith(fontSize: 28),
              ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.2),

              const SizedBox(height: AppConstants.defaultPadding / 2),

              ...experiences.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                return ExpandableInfoCard(
                  title: item['title']!,
                  subtitle: item['subtitle']!,
                  description: item['description']!,
                ).animate().fadeIn(delay: (700 + idx * 100).ms).slideY(begin: 0.2);
              }),

              const SizedBox(height: AppConstants.sectionSpacing),

              /// Education Section
              Text(
                'Education',
                style: textTheme.displayLarge?.copyWith(fontSize: 28),
              ).animate().fadeIn(delay: 900.ms).slideX(begin: -0.2),

              const SizedBox(height: AppConstants.defaultPadding / 2),

              ...educations.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                return ExpandableInfoCard(
                  title: item['title']!,
                  subtitle: item['subtitle']!,
                  description: item['description']!,
                ).animate().fadeIn(delay: (1000 + idx * 100).ms).slideY(begin: 0.2);
              }),

              const SizedBox(height: AppConstants.sectionSpacing),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
