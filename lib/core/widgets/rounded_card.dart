import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class RoundedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? elevation;

  const RoundedCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      color: color ?? Theme.of(context).cardColor,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppConstants.defaultPadding),
        child: child,
      ),
    );
  }
}