import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/controllers/historic_workout_create_controller.dart';
import 'package:flex_workout_mobile/features/history/controllers/historic_workout_list_controller.dart';
import 'package:flex_workout_mobile/features/history/controllers/tracked_workout_list_controller.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracked_workout_create_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/main_tracker_app_bar.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/workout_summary_bottom_bar.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/workout_summary_header.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/workout_summary_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WorkoutSummaryScreen extends ConsumerWidget {
  const WorkoutSummaryScreen({required this.back, super.key});

  final VoidCallback back;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<HistoricWorkoutModel?>(
      historicWorkoutCreateControllerProvider,
      (previous, next) {
        if (next == null) return;

        ref
            .read(historicWorkoutListControllerProvider.notifier)
            .addWorkout(next);
        context.pop();
      },
    );

    return Column(
      children: [
        const MainTrackerAppBar(),
        Expanded(
          child: ListView(
            children: [
              const WorkoutSummaryHeader(),
              const SizedBox(height: AppLayout.p4),
              Divider(color: context.colors.divider, height: 0),
              const SizedBox(height: AppLayout.p6),
              const WorkoutSummaryOverview(),
              const SizedBox(height: AppLayout.bottomBuffer),
            ],
          ),
        ),
        WorkoutSummaryBottomBar(back: back),
      ],
    );
  }
}
