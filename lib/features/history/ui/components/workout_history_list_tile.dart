import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryListTile extends StatelessWidget {
  const WorkoutHistoryListTile({required this.workout, super.key});

  final HistoricWorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    return Section(
      subHeader: workout.title,
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
                      padding: const EdgeInsets.symmetric(
                        vertical: AppLayout.p2,
                      ),
                      child: Text(
                        'Exercise',
                        style: context.typography.labelMedium.copyWith(
                          color: context.colors.foregroundSecondary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppLayout.p2,
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
                        top: AppLayout.p2,
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
                // ...workout.sections.map(
                //   (e) {
                //     switch (e) {
                //       case final HistoricDefaultSectionModel obj:
                //         return _defaultSectionRow(
                //           context,
                //           defaultSet: obj.bestSet(),
                //           numberOfSets: obj.sets.length,
                //         );
                //       case final HistoricSupersetSectionModel obj:
                //         return [0, 1].map((_) => TableRow(children: [
                //               Text('Test'),
                //               Text(''),
                //               Text(''),
                //             ]));
                //     }
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _defaultSectionRow(
    BuildContext context, {
    required IHistoricSet defaultSet,
    required int numberOfSets,
  }) {
    switch (defaultSet) {
      case final HistoricDefaultSetModel obj:
        return TableRow(
          children: [
            ..._defaultSetRow(
              context,
              defaultSet: obj,
              numberOfSets: numberOfSets,
            ),
          ],
        );
    }
  }

  TableRow _supersetSectionRow({
    required Map<String, IHistoricSet> bestSets,
  }) {
    return TableRow(
      children: [
        Text('Test'),
        Text(''),
        Text(''),
      ],
    );
  }

  List<Widget> _defaultSetRow(
    BuildContext context, {
    required HistoricDefaultSetModel defaultSet,
    required int numberOfSets,
  }) {
    return [
      Text(
        defaultSet.exercise.name,
        style: context.typography.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        numberOfSets.toString(),
        textAlign: TextAlign.end,
        style: context.typography.labelMedium,
      ),
      Text(
        defaultSet.load.toString(),
        textAlign: TextAlign.end,
        style: context.typography.labelMedium,
      ),
    ];
  }
}
