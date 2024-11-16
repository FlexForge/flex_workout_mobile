import 'package:flex_workout_mobile/core/common/ui/components/back_button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_view_controller.dart';
import 'package:flex_workout_mobile/features/workout/ui/containers/workout_muscle_groups.dart';
import 'package:flex_workout_mobile/features/workout/ui/containers/workout_overview.dart';
import 'package:flex_workout_mobile/features/workout/ui/containers/workout_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutViewScreen extends ConsumerWidget {
  const WorkoutViewScreen({required this.id, super.key});

  final String id;

  static const routeName = 'workout_view';
  static const routePath = 'workout/:wid';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workout = ref.watch(workoutViewControllerProvider(id));

    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      appBar: CupertinoNavigationBar(
        middle: Text(
          workout.title,
          style: TextStyle(color: context.colors.foregroundPrimary),
        ),
        leading: const FlexBackButton(),
        backgroundColor: context.colors.backgroundSecondary,
        border: null,
        padding: EdgeInsetsDirectional.zero,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        child: Column(
          children: [
            WorkoutSummary(workout: workout),
            const SizedBox(height: AppLayout.p6),
            WorkoutOverview(workout: workout),
            const SizedBox(height: AppLayout.p4),
            WorkoutMuscleGroups(workout: workout),
            const SizedBox(height: AppLayout.bottomBuffer),
          ],
        ),
      ),
    );
  }
}
