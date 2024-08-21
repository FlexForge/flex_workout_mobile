import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/core/utils/get_colors.dart';
import 'package:flex_workout_mobile/features/history/controllers/tracked_workout_list_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryListTile extends StatelessWidget {
  const WorkoutHistoryListTile({required this.workout, super.key});

  final TrackedWorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    final sections = workout.sections.toWorkoutHistoryTable();

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
                ...sections.map(
                  (e) => TableRow(
                    decoration: e.superSetIndex != null
                        ? BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: getColorFromIndex(
                                  context,
                                  e.superSetIndex!,
                                ),
                                width: 4,
                              ),
                            ),
                          )
                        : null,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: e.superSetIndex != null ? AppLayout.p3 : 0,
                          top:
                              sections.first != e ? AppLayout.p1 : AppLayout.p2,
                          bottom: AppLayout.p1,
                        ),
                        child: Text(
                          e.title,
                          style: context.typography.labelMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top:
                              sections.first != e ? AppLayout.p1 : AppLayout.p2,
                          bottom: AppLayout.p1,
                          left: AppLayout.p3,
                        ),
                        child: Text(
                          e.sets.toString(),
                          textAlign: TextAlign.end,
                          style: context.typography.labelMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top:
                              sections.first != e ? AppLayout.p1 : AppLayout.p2,
                          bottom: AppLayout.p1,
                          left: AppLayout.p3,
                        ),
                        child: Text(
                          e.bestSet,
                          textAlign: TextAlign.end,
                          style: context.typography.labelMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
