import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/config/router.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class WorkoutOverview extends StatelessWidget {
  const WorkoutOverview({
    required this.workout,
    super.key,
  });

  final WorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    return Section(
      header: 'Overview',
      subHeader: 'Workout Summary',
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
      body: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: workout.sections.length,
        itemBuilder: (context, index) {
          final section = workout.sections[index];

          switch (section) {
            case final SupersetWorkoutSectionModel supersetSection:
              return FlexListTile(
                title: Text(
                  supersetSection.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colors.foregroundPrimary,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      supersetSection.getTotalSets().values.join('-'),
                      style: context.typography.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundPrimary,
                      ),
                    ),
                    Text(
                      ' sets',
                      style: context.typography.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundSecondary,
                      ),
                    ),
                    const SizedBox(width: AppLayout.p1),
                    Icon(
                      Symbols.close,
                      size: 10,
                      weight: 700,
                      color: context.colors.foregroundSecondary,
                    ),
                    const SizedBox(width: AppLayout.p1),
                    Text(
                      supersetSection.minReps.toString(),
                      style: context.typography.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundPrimary,
                      ),
                    ),
                    if (supersetSection.maxReps != null) ...[
                      Text(
                        '-${supersetSection.maxReps}',
                        style: context.typography.bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.colors.foregroundPrimary,
                        ),
                      ),
                    ],
                    Text(
                      // ignore: lines_longer_than_80_chars
                      ' rep${supersetSection.minReps > 1 || supersetSection.maxReps != null ? 's' : ''}',
                      style: context.typography.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundSecondary,
                      ),
                    ),
                  ],
                ),
              );
            case final DefaultWorkoutSectionModel defaultSection:
              return FlexListTile(
                disabledForegroundColor: context.colors.foregroundPrimary,
                title: Text(
                  defaultSection.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      defaultSection.totalSets.toString(),
                      style: context.typography.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundPrimary,
                      ),
                    ),
                    Text(
                      ' set${defaultSection.totalSets > 1 ? 's' : ''}',
                      style: context.typography.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundSecondary,
                      ),
                    ),
                    const SizedBox(width: AppLayout.p1),
                    Icon(
                      Symbols.close,
                      size: 10,
                      weight: 700,
                      color: context.colors.foregroundSecondary,
                    ),
                    const SizedBox(width: AppLayout.p1),
                    Text(
                      defaultSection.minReps.toString(),
                      style: context.typography.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundPrimary,
                      ),
                    ),
                    if (defaultSection.maxReps != null) ...[
                      Text(
                        '-${defaultSection.maxReps}',
                        style: context.typography.bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.colors.foregroundPrimary,
                        ),
                      ),
                    ],
                    Text(
                      // ignore: lines_longer_than_80_chars
                      ' rep${defaultSection.minReps > 1 || defaultSection.maxReps != null ? 's' : ''}',
                      style: context.typography.bodySmall.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundSecondary,
                      ),
                    ),
                  ],
                ),
              );
          }
        },
        separatorBuilder: (context, index) => Divider(
          height: 1,
          indent: 54,
          color: context.colors.divider,
        ),
      ),
    );
  }
}
