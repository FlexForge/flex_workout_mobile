import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/core/utils/get_colors.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_view.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class WorkoutSummaryOverview extends ConsumerWidget {
  const WorkoutSummaryOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(trackerFormControllerProvider);

    final exerciseSummary =
        ref.read(trackerFormControllerProvider.notifier).getWorkoutSummary();

    return Column(
      children: [
        Section(
          header: 'Overview',
          subHeader:
              form.model.sections.isNotEmpty ? 'Exercises Completed' : null,
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          body: form.model.sections.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: exerciseSummary.length,
                  itemBuilder: (context, index) {
                    final summary = exerciseSummary[index];

                    return FlexListTile(
                      onTap: () => {},
                      title: Text(
                        summary.exercise.name,
                        style: context.typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailingIcon: Symbols.info,
                      borderColor: summary.superSetIndex != null
                          ? getColorFromIndex(
                              context,
                              summary.superSetIndex!,
                            )
                          : null,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: 54,
                      height: 0,
                      color: context.colors.divider,
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppLayout.p6),
                  child: Center(
                    child: Text(
                      'No exercises recorded',
                      style: context.typography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundSecondary,
                      ),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: AppLayout.p3),
        Section(
          subHeader: form.model.primaryMuscleGroups.isNotEmpty
              ? 'Muscle Groups Targeted'
              : null,
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          body: form.model.primaryMuscleGroups.isNotEmpty
              ? MuscleGroupView(
                  primaryMuscleGroups: form.model.primaryMuscleGroups,
                  secondaryMuscleGroups: form.model.secondaryMuscleGroups,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppLayout.p6),
                  child: Center(
                    child: Text(
                      'No muscles targeted',
                      style: context.typography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.colors.foregroundSecondary,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
