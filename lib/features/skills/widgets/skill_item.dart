import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/rounded_card.dart';

class SkillItem extends StatefulWidget {
  final String name;
  final IconData icon;

  const SkillItem({super.key, required this.name, required this.icon});

  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: false); // makes animation continuous
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() => isHovered = true);
    _controller.repeat();
  }

  void _onExit(PointerExitEvent event) {
    setState(() => isHovered = false);
    _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: isHovered
                ? (Matrix4.identity()..translate(0.0, -4.0)..scale(1.02))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
              boxShadow: isHovered
                  ? [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.3),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ]
                  : [],
            ),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0.0, 0.5, 1.0],
                  colors: [
                    Colors.transparent,
                    isHovered ? Colors.blue.withOpacity(0.3) : Colors.transparent,
                    Colors.transparent,
                  ],
                  transform: SlidingGradientTransform(_animation.value),
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: RoundedCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: AppConstants.defaultPadding * 0.75,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(widget.icon, size: 24, color: colorScheme.secondary),
                    const SizedBox(width: AppConstants.defaultPadding / 2),
                    Expanded(
                      child: Text(
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium!.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const SlidingGradientTransform(this.slidePercent);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
