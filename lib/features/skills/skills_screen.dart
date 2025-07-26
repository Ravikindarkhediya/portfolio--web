import 'package:flutter/material.dart';
import 'package:modern_portfolio/features/skills/widgets/skill_item.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_constants.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  final List<Map<String, dynamic>> _skills = const [
    {'name': 'Flutter', 'icon': FontAwesomeIcons.mobileScreenButton},
    {'name': 'Dart', 'icon': FontAwesomeIcons.code},
    {'name': 'Firebase', 'icon': FontAwesomeIcons.fire},
    {'name': 'REST APIs', 'icon': FontAwesomeIcons.server},
    {'name': 'GetX', 'icon': Icons.settings_ethernet},
    {'name': 'Provider', 'icon': Icons.account_tree},
    {'name': 'Git & GitHub', 'icon': FontAwesomeIcons.github},
    {'name': 'SQLite', 'icon': FontAwesomeIcons.database},
  ];

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
                'My Skills',
                style: GoogleFonts.poppins(
                  textStyle: textTheme.displayLarge,
                  fontSize: 32,
                ),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
              const SizedBox(height: AppConstants.defaultPadding),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _skills.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: AppConstants.defaultPadding,
                  mainAxisSpacing: AppConstants.defaultPadding,
                ),
                itemBuilder: (context, index) {
                  final skill = _skills[index];
                  return SkillItem(
                    name: skill['name'],
                    icon: skill['icon'],
                  ).animate().fadeIn(
                    delay: (300 + index * 100).ms,
                  ).scale(begin: const Offset(0.8, 0.8));
                },
              ),
              const SizedBox(height: AppConstants.sectionSpacing * 2),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
