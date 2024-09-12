import 'dart:async';

import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/common/ui/components/stacked_text.dart';
import 'package:flex_workout_mobile/core/common/ui/components/text_with_color.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_view.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/live_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MainTrackerSummary extends ConsumerStatefulWidget {
  const MainTrackerSummary({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainTrackerSummaryState();
}

class _MainTrackerSummaryState extends ConsumerState<MainTrackerSummary> {
  String _timeString = '';
  late Timer _timer;

  @override
  void initState() {
    final startTime = ref.read(liveWorkoutControllerProvider).startTimestamp;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final difference = DateTime.now().difference(startTime);

        _timeString = DateFormat('HH:mm:ss').format(
          DateTime(0, 0, 0, 0, 0, difference.inSeconds),
        );
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workout = ref.watch(liveWorkoutControllerProvider);
    final totalVolume = ref
        .watch(liveWorkoutControllerProvider.notifier)
        .getTotalVolume(Units.lbs);
    final totalSets =
        ref.watch(liveWorkoutControllerProvider.notifier).getSetsCompleted();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: Text(
            'Workout Summary',
            style: context.typography.headlineMedium
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: AppLayout.p4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: LayoutGrid(
            columnSizes: [1.fr, 1.fr, 1.fr],
            rowSizes: const [auto, auto],
            rowGap: AppLayout.p4, // equivalent to mainAxisSpacing
            columnGap: AppLayout.p4,
            children: [
              TextWithColor(
                color: context.colors.blue,
                label: 'Total volume',
                value: totalVolume.toString(),
                isLarge: true,
              ),
              TextWithColor(
                color: context.colors.green,
                label: 'Sets completed',
                value: totalSets.toString(),
                isLarge: true,
              ),
              TextWithColor(
                color: context.colors.yellow,
                label: 'Reps completed',
                value: '0',
                isLarge: true,
              ),
              StackedText(
                heading: workout.startTimestamp.toReadableTime(),
                subHeading: 'Start Time',
                alignment: CrossAxisAlignment.start,
              ),
              StackedText(
                heading: _timeString.isEmpty ? '00:00:00' : _timeString,
                subHeading: 'Workout length',
                alignment: CrossAxisAlignment.start,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppLayout.p4),
        Section(
          subHeader: workout.primaryMuscleGroups.isNotEmpty
              ? 'Muscle Groups Targeted'
              : null,
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          body: workout.primaryMuscleGroups.isNotEmpty
              ? MuscleGroupView(
                  primaryMuscleGroups: workout.primaryMuscleGroups,
                  secondaryMuscleGroups: workout.secondaryMuscleGroups,
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
