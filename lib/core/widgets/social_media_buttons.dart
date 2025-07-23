import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/app_constants.dart';
import '../utils/helpers.dart';

class SocialMediaButtons extends StatelessWidget {
  final MainAxisAlignment alignment;
  final double iconSize;

  const SocialMediaButtons({
    super.key,
    this.alignment = MainAxisAlignment.center,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: <Widget>[
        IconButton(
          icon: FaIcon(FontAwesomeIcons.github, size: iconSize, color: Theme.of(context).colorScheme.onBackground,),
          onPressed: () => launchURL(AppConstants.githubUrl),
          tooltip: 'GitHub',
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.linkedinIn, size: iconSize, color: Theme.of(context).colorScheme.onBackground),
          onPressed: () => launchURL(AppConstants.linkedinUrl),
          tooltip: 'LinkedIn',
        ),
      ],
    );
  }
}