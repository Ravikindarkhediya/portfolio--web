import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/rounded_card.dart';

class EducationTile extends StatelessWidget {
  final String degree;
  final String institution;
  final String year;
  final String? details;

  const EducationTile({
    super.key,
    required this.degree,
    required this.institution,
    required this.year,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RoundedCard(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding / 2),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(degree, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text("$institution | $year", style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
        children: <Widget>[
          if (details != null && details!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 8.0),
              child: Text(
                details!,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ),
        ],
      ),
    );
  }
}