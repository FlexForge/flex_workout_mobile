import 'package:flex_workout_mobile/core/common/ui/components/back_button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/controllers/historic_workout_view_controller.dart';
import 'package:flex_workout_mobile/features/history/ui/containers/historic_workout_overview.dart';
import 'package:flex_workout_mobile/features/history/ui/containers/historic_workout_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoricWorkoutViewScreen extends ConsumerWidget {
  const HistoricWorkoutViewScreen({required this.id, super.key});

  final String id;

  static const routeName = 'historic_workout_view';
  static const routePath = 'historic_workout/:wid';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workout = ref.watch(historicWorkoutViewControllerProvider(id));

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
            HistoricWorkoutSummary(workout: workout),
            const SizedBox(height: AppLayout.p6),
            HistoricWorkoutOverview(workout: workout),
          ],
        ),
      ),
    );
  }
}
