import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/rounded_card.dart';

class ExpandableInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;

  const ExpandableInfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hover = false.obs;

    return MouseRegion(
      onEnter: (_) => hover.value = true,
      onExit: (_) => hover.value = false,
      child: Obx(() => AnimatedScale(
        scale: hover.value ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            boxShadow: hover.value
                ? [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
                blurRadius: 16,
                offset: const Offset(0, 6),
              )
            ]
                : [],
          ),
          child: RoundedCard(
            margin: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding / 2),
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                title,
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                subtitle,
                style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    description,
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
