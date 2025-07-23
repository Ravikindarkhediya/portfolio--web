import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/rounded_card.dart';
import 'widgets/education_tile.dart';
import 'widgets/experience_tile.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Dummy Data (move to a separate file or controller if it gets complex)
    final List<Map<String, String>> experiences = [
      {
        "role": "Flutter Developer",
        "company": "CreativeInfoWay",
        "duration": "May 2025 - Ongoing",
        "description":
        "Developed and maintained features for various client projects using Flutter and Dart. Collaborated with UI/UX designers."
      },
    ];

    final List<Map<String, String>> educations = [
      {
        "degree": "Bachelor Computer of Science",
        "institution": "Bhakta Kavi Narsinh Mehta University",
        "year": "2024",
        "details": "Developed applications and websites while learning various programming languages."
      },
    ];


    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About Me", style: textTheme.displayLarge?.copyWith(fontSize: 32))
                  .animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
              const SizedBox(height: AppConstants.defaultPadding),
              RoundedCard(
                child: Text(
                  AppStrings.bio,
                  style: textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.6),
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

              const SizedBox(height: AppConstants.sectionSpacing),
              Text("Experience", style: textTheme.displayLarge?.copyWith(fontSize: 28))
                  .animate().fadeIn(delay: 600.ms).slideX(begin: -0.2),
              const SizedBox(height: AppConstants.defaultPadding / 2),
              ...experiences.asMap().entries.map((entry) {
                int idx = entry.key;
                Map<String, String> exp = entry.value;
                return ExperienceTile(
                  role: exp['role']!,
                  company: exp['company']!,
                  duration: exp['duration']!,
                  description: exp['description']!,
                ).animate().fadeIn(delay: (700 + idx * 100).ms).slideY(begin: 0.2);
              }).toList(),

              const SizedBox(height: AppConstants.sectionSpacing),
              Text("Education", style: textTheme.displayLarge?.copyWith(fontSize: 28))
                  .animate().fadeIn(delay: 900.ms).slideX(begin: -0.2),
              const SizedBox(height: AppConstants.defaultPadding / 2),
              ...educations.asMap().entries.map((entry) {
                int idx = entry.key;
                Map<String, String> edu = entry.value;
                return EducationTile(
                  degree: edu['degree']!,
                  institution: edu['institution']!,
                  year: edu['year']!,
                  details: edu['details']!,
                ).animate().fadeIn(delay: (1000 + idx * 100).ms).slideY(begin: 0.2);
              }).toList(),
              const SizedBox(height: AppConstants.sectionSpacing),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}