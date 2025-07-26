import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/animated_typing_text.dart';
import '../../core/widgets/social_media_buttons.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.put(HomeController());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding * 1.5),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppConstants.sectionSpacing / 2),

              MouseRegion(
                onEnter: (_) => controller.onHoverEnter(),
                onExit: (_) => controller.onHoverExit(),
                child: Obx(
                      () => AnimatedScale(
                    scale: controller.isHovered.value ? 1.4 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: controller.isHovered.value
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/man.jpg',
                          fit: BoxFit.cover,
                          width: 150,
                          height: 150,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person, size: 80),
                        ),
                      ),
                    ),
                  ),
                ),
              ),



              const SizedBox(height: AppConstants.defaultPadding * 2),

              Text(
                AppStrings.developerName,
                style: textTheme.displayLarge?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.5, duration: 500.ms),

              const SizedBox(height: AppConstants.defaultPadding / 2),

              /// 🔤 Typing Animation
              AnimatedTypingText(
                texts: AppStrings.animatedTexts,
                textStyle: textTheme.titleLarge?.copyWith(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),

              const SizedBox(height: AppConstants.defaultPadding * 1.5),

              Text(
                'Welcome to my personal portfolio. Explore my work and get in touch!',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.5),
              ).animate().fadeIn(delay: 1200.ms),

              const SizedBox(height: AppConstants.defaultPadding * 2),

              /// 🔗 Social Media Icons
              const SocialMediaButtons(iconSize: 28)
                  .animate().fadeIn(delay: 1500.ms),

              const SizedBox(height: AppConstants.sectionSpacing),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
