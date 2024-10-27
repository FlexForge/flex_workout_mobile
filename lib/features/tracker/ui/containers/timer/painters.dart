import 'dart:math' as math;

import 'package:flutter/material.dart';

class WorkoutTimerPainter extends CustomPainter {
  WorkoutTimerPainter({
    required this.animation,
    required this.fillColor,
    required this.ringColor,
    this.fillWidth = 2.0,
    this.ringWidth = 2.0,
    this.strokeCap = StrokeCap.round,
  }) : super(repaint: animation);

  final Animation<double> animation;

  final Color ringColor;
  final Color fillColor;

  final double fillWidth;
  final double ringWidth;
  final StrokeCap strokeCap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ringColor
      ..strokeWidth = ringWidth
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    final progress = animation.value * 2 * math.pi;
    const startAngle = math.pi * 1.5;

    paint
      ..color = fillColor
      ..strokeWidth = fillWidth;
    canvas.drawArc(Offset.zero & size, startAngle, progress, false, paint);
  }

  @override
  bool shouldRepaint(WorkoutTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        ringColor != oldDelegate.ringColor ||
        fillColor != oldDelegate.fillColor;
  }
}

class WorkoutLineTimerPainter extends CustomPainter {
  WorkoutLineTimerPainter({
    required this.animation,
    required this.fillColor,
    required this.lineColor,
    this.fillWidth = 2.0,
    this.lineWidth = 2.0,
    this.strokeCap = StrokeCap.round,
  }) : super(repaint: animation);

  final Animation<double> animation;

  final Color lineColor;
  final Color fillColor;

  final double fillWidth;
  final double lineWidth;
  final StrokeCap strokeCap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset.zero,
      Offset(size.width, 0),
      paint,
    );

    paint
      ..color = fillColor
      ..strokeWidth = fillWidth;
    canvas.drawLine(
      Offset.zero,
      Offset(size.width - (size.width * animation.value), 0),
      paint,
    );
  }

  @override
  bool shouldRepaint(WorkoutLineTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        lineColor != oldDelegate.lineColor ||
        fillColor != oldDelegate.fillColor;
  }
}
