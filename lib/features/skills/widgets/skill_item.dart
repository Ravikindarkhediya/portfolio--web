import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/rounded_card.dart';

class SkillItem extends StatelessWidget {
  final String name;
  final IconData icon;

  const SkillItem({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RoundedCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.defaultPadding * 0.75,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: AppConstants.defaultPadding / 2),
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
