import 'package:flex_workout_mobile/core/common/controllers/app_controller.dart';
import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/main_tracker_info_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/live_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracked_workout_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class WorkoutSummaryBottomBar extends ConsumerWidget {
  const WorkoutSummaryBottomBar({required this.back, super.key});

  final VoidCallback back;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workout = ref.watch(liveWorkoutControllerProvider);
    final form = ref.watch(mainTrackerInfoFormControllerProvider);

    void logWorkout() {
      ref
          .read(trackedWorkoutCreateControllerProvider.notifier)
          .handle(form, workout);

      ref
        ..invalidate(liveWorkoutControllerProvider)
        ..invalidate(mainTrackerInfoFormControllerProvider);
      ref.read(appControllerProvider.notifier).endWorkout();
    }

    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colors.divider), // Top border
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            LargeButton(
              onPressed: back,
              icon: Symbols.chevron_left,
              backgroundColor: context.colors.backgroundSecondary,
            ),
            const SizedBox(width: AppLayout.p2),
            Expanded(
              child: LargeButton(
                onPressed: logWorkout,
                label: 'Log Workout',
                icon: Symbols.add_task,
                backgroundColor: context.colors.foregroundPrimary,
                foregroundColor: context.colors.backgroundPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
