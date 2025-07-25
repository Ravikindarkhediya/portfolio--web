import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/app_constants.dart';
import '../../core/widgets/rounded_card.dart';
import '../../core/widgets/social_media_buttons.dart';
import 'contact_controller.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({super.key});

  final ContactController controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get In Touch', style: textTheme.displayLarge?.copyWith(fontSize: 32))
                  .animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
              const SizedBox(height: AppConstants.defaultPadding / 2),
              Text(
                'Have a project in mind or just want to say hi? Feel free to reach out!',
                style: textTheme.bodyMedium,
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: AppConstants.defaultPadding * 1.5),
              RoundedCard(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                          labelText: 'Your Name',
                          labelStyle: textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).colorScheme.secondary),
                          border: const OutlineInputBorder(),
                        ),
                        validator: controller.validateName,
                      ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.2),
                      const SizedBox(height: AppConstants.defaultPadding),
                      TextFormField(
                        controller: controller.emailController,
                        decoration:  InputDecoration(
                          labelText: 'Your Email',
                          labelStyle: textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          prefixIcon: Icon(Icons.email_outlined, color: Theme.of(context).colorScheme.secondary),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: controller.validateEmail,
                      ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2),
                      const SizedBox(height: AppConstants.defaultPadding),
                      TextFormField(
                        controller: controller.messageController,
                        decoration: InputDecoration(
                          labelText: 'Your Message',
                          labelStyle: textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          prefixIcon: Icon(Icons.message_outlined, color: Theme.of(context).colorScheme.secondary),
                          border: const OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 5,
                        validator: controller.validateMessage,
                      ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.2),
                      const SizedBox(height: AppConstants.defaultPadding * 1.5),
                      Obx(() => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton.icon(
                        icon: const Icon(Icons.send_outlined),
                        label: const Text('Send Message'),
                        onPressed: controller.submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.9),
                        ),
                      )
                      ).animate().fadeIn(delay: 700.ms),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.sectionSpacing),
              Center(
                child: Text(
                  'Or connect with me on social media:',
                  style: textTheme.titleMedium,
                ).animate().fadeIn(delay: 800.ms),
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              const SocialMediaButtons(alignment: MainAxisAlignment.center, iconSize: 30)
                  .animate().fadeIn(delay: 900.ms).slideY(begin: 0.5),
              const SizedBox(height: AppConstants.sectionSpacing),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}