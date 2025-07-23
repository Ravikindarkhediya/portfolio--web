import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/rounded_card.dart';

class ExperienceTile extends StatelessWidget {
  final String role;
  final String company;
  final String duration;
  final String description;

  const ExperienceTile({
    super.key,
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RoundedCard(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding / 2),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(role, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text("$company | $duration", style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 8.0),
            child: Text(
              description,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}