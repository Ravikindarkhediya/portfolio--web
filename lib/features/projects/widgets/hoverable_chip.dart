import 'package:flutter/material.dart';

class HoverableChip extends StatefulWidget {
  final String label;
  final Color baseColor;
  final TextStyle textStyle;

  const HoverableChip({
    Key? key,
    required this.label,
    required this.baseColor,
    required this.textStyle,
  }) : super(key: key);

  @override
  State<HoverableChip> createState() => _HoverableChipState();
}

class _HoverableChipState extends State<HoverableChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.baseColor.withOpacity(0.2)
              : widget.baseColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? widget.baseColor : Colors.transparent,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          widget.label,
          style: widget.textStyle.copyWith(
            color: _isHovered ? widget.baseColor : widget.baseColor,
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
