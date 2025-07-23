import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTypingText extends StatelessWidget {
  final List<String> texts;
  final TextStyle? textStyle;

  const AnimatedTypingText({super.key, required this.texts, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: texts.map((text) => TyperAnimatedText(
        text,
        textStyle: textStyle ?? Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.secondary, // Accent color
          fontWeight: FontWeight.bold,
        ),
        speed: const Duration(milliseconds: 100),
      )).toList(),
      repeatForever: true,
    );
  }
}