import 'dart:math';
import 'dart:ui';

import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/analytics/data/models/line_graph_model.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class LineGraphTile extends StatelessWidget {
  const LineGraphTile({required this.graph, this.color, super.key});

  final LineGraphModel graph;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: CustomPaint(
        size: Size.infinite,
        painter: GraphPainter(
          color: color ?? context.colors.blue,
          points: graph.points,
        ),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  GraphPainter({
    required this.color,
    required this.points,
  });

  final Color color;
  List<LineGraphPoint> points;

  @override
  void paint(Canvas canvas, Size size) {
    final getMaxPoint = points.fold(points.first.yAxis, (prev, e) {
      return max(prev, e.yAxis);
    });
    final getMinPoint = points.fold(points.first.yAxis, (prev, e) {
      return min(prev, e.yAxis);
    });

    final widthRatio = size.width / (points.length - 1);

    final mainPaint = Paint()
      ..color = color
      ..strokeWidth = 2;

    final offsets = points.reversed.mapWithIndex((point, index) {
      final y =
          ((point.yAxis - getMinPoint) / (getMaxPoint - getMinPoint + 1)) *
              size.height;
      return Offset(widthRatio * index, y);
    }).toList();

    canvas.drawPoints(PointMode.polygon, offsets, mainPaint);

    for (final offset in offsets) {
      canvas.drawCircle(offset, 4, mainPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
