import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/num_extensions.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/controllers/historic_workout_list_controller.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class HistoricWorkoutTile extends ConsumerWidget {
  const HistoricWorkoutTile({required this.workout, super.key});

  final HistoricWorkoutModel workout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref
        .watch(historicWorkoutListControllerProvider.notifier)
        .getWorkoutHistoryTable(workout);

    return Section(
      subHeader: workout.title,
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
      body: Container(
        padding: const EdgeInsets.only(
          left: AppLayout.p4,
          right: AppLayout.p4,
          bottom: AppLayout.p4,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  workout.subtitle,
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat.yMMMEd().format(workout.startTimestamp),
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppLayout.p2),
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(3),
                1: IntrinsicColumnWidth(),
                2: IntrinsicColumnWidth(),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: context.colors.divider,
                      ),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppLayout.p2,
                        right: AppLayout.p3,
                      ),
                      child: Text(
                        'Exercise',
                        style: context.typography.labelMedium.copyWith(
                          color: context.colors.foregroundSecondary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppLayout.p2,
                        right: AppLayout.p3,
                        left: AppLayout.p3,
                      ),
                      child: Text(
                        'Sets',
                        textAlign: TextAlign.end,
                        style: context.typography.labelMedium.copyWith(
                          color: context.colors.foregroundSecondary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppLayout.p2,
                        left: AppLayout.p3,
                      ),
                      child: Text(
                        'Best set',
                        textAlign: TextAlign.end,
                        style: context.typography.labelMedium.copyWith(
                          color: context.colors.foregroundSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const TableRow(
                  children: [
                    SizedBox(height: AppLayout.p1),
                    SizedBox(height: AppLayout.p1),
                    SizedBox(height: AppLayout.p1),
                  ],
                ),
                ...summary.map((cell) {
                  switch (cell.bestSet) {
                    case final HistoricDefaultSetModel obj:
                      return _defaultSetTableRow(
                        context,
                        defaultSet: obj,
                        numberOfSets: cell.numberOfSets,
                      );
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _defaultSetTableRow(
    BuildContext context, {
    required HistoricDefaultSetModel defaultSet,
    required int numberOfSets,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppLayout.p1,
            bottom: AppLayout.p1,
          ),
          child: Text(
            defaultSet.exercise.name,
            style: context.typography.labelMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppLayout.p1,
            horizontal: AppLayout.p3,
          ),
          child: Text(
            numberOfSets.toString(),
            textAlign: TextAlign.end,
            style: context.typography.labelMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: AppLayout.p1,
            bottom: AppLayout.p1,
            left: AppLayout.p3,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                defaultSet.load.cleanNumber(),
                style: context.typography.labelMedium,
              ),
              Text(
                ' ${defaultSet.units.name}',
                style: context.typography.labelMedium.copyWith(
                  color: context.colors.foregroundSecondary,
                ),
              ),
              const SizedBox(width: AppLayout.p1),
              Icon(
                Symbols.close,
                size: 12,
                weight: 700,
                color: context.colors.foregroundTertiary,
              ),
              const SizedBox(width: AppLayout.p1),
              Text(
                defaultSet.reps.toString(),
                style: context.typography.labelMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
