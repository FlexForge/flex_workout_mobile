import 'dart:math' as math;

import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';

class SummaryHighlight extends StatelessWidget {
  const SummaryHighlight({
    required this.diameter,
    required this.color,
    required this.value,
    required this.label,
    super.key,
  });

  final double diameter;
  final Color color;

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(color: color),
      size: Size(diameter, diameter),
      child: SizedBox(
        width: diameter,
        height: diameter,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: context.typography.headlineLarge.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: context.colors.foregroundPrimary,
                ),
              ),
              Text(
                label,
                style: context.typography.labelMedium.copyWith(
                  color: context.colors.foregroundSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  const MyPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      3 * math.pi / 4,
      3 * math.pi / 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
