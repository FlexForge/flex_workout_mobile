import 'package:flex_workout_mobile/core/extensions/num_extensions.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/ui/components/summary_highlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutSummaryHeader extends ConsumerWidget {
  const WorkoutSummaryHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workout = ref.watch(workoutControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: Text(
            'You crushed it!',
            style: context.typography.headlineLarge
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: AppLayout.p6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SummaryHighlight(
                diameter: 110,
                color: context.colors.blue,
                value: workout.getVolume().cleanNumber(decimal: 0),
                label: 'lbs',
              ),
              const Spacer(),
              SummaryHighlight(
                diameter: 110,
                color: context.colors.yellow,
                value: workout.getTotalSets().cleanNumber(decimal: 0),
                label: 'sets',
              ),
              const Spacer(),
              SummaryHighlight(
                diameter: 110,
                color: context.colors.green,
                value: workout.durationInMinutes.toString(),
                label: 'minutes',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
