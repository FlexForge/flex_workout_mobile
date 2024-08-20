import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryListTile extends StatelessWidget {
  const WorkoutHistoryListTile({required this.workout, super.key});

  final TrackedWorkoutModel workout;

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
            const SizedBox(height: AppLayout.p4),
            Table(
              children: workout.sections
                  .map(
                    (e) => TableRow(
                      children: [
                        Text(
                          e.title,
                          style: context.typography.labelMedium.copyWith(
                            color: context.colors.foregroundSecondary,
                          ),
                        ),
                        Text(
                          e.organizers.length.toString(),
                          style: context.typography.labelMedium.copyWith(
                            color: context.colors.foregroundSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
