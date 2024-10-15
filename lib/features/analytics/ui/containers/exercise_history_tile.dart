import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/analytics/data/models/line_graph_model.dart';
import 'package:flex_workout_mobile/features/analytics/ui/line_graph/line_graph_tile.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

final example = LineGraphModel(
  name: '1 RM',
  points: [
    LineGraphPoint(xAxis: 0, yAxis: 56),
    LineGraphPoint(xAxis: 0, yAxis: 61),
    LineGraphPoint(xAxis: 0, yAxis: 63),
    LineGraphPoint(xAxis: 0, yAxis: 65),
    LineGraphPoint(xAxis: 0, yAxis: 69),
    LineGraphPoint(xAxis: 0, yAxis: 72),
  ],
);

class ExerciseHistoryTile extends StatelessWidget {
  const ExerciseHistoryTile({
    required this.padding,
    this.graphColor,
    super.key,
  });

  final EdgeInsets padding;
  final Color? graphColor;

  @override
  Widget build(BuildContext context) {
    return Section(
      padding: padding,
      subHeader: example.name,
      body: Container(
        padding: const EdgeInsets.only(
          left: AppLayout.p4,
          right: AppLayout.p4,
          bottom: AppLayout.p4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sept 18 - now',
              style: context.typography.labelMedium.copyWith(
                color: context.colors.foregroundSecondary,
              ),
            ),
            const SizedBox(height: AppLayout.p2),
            LineGraphTile(graph: example, color: graphColor),
            const SizedBox(height: AppLayout.p4),
            Divider(
              height: 1,
              color: context.colors.divider,
            ),
            const SizedBox(height: AppLayout.p2),
            Row(
              children: [
                Text(
                  '328.4',
                  style: context.typography.labelLarge,
                ),
                const SizedBox(width: AppLayout.p1),
                Text(
                  'lbs',
                  style: context.typography.labelLarge
                      .copyWith(color: context.colors.foregroundSecondary),
                ),
                const Icon(Symbols.chevron_right, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
