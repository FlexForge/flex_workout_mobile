import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_alert_dialog.dart';
import 'package:flex_workout_mobile/core/common/ui/components/icon_text_display.dart';
import 'package:flex_workout_mobile/core/common/ui/components/stacked_text.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_delete_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_edit_screen.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/video_demo_screen.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class WorkoutSummary extends ConsumerWidget {
  const WorkoutSummary({required this.workout, super.key});

  final WorkoutModel workout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: context.colors.backgroundSecondary,
      padding: const EdgeInsets.only(top: AppLayout.p2, bottom: AppLayout.p4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StackedText(
                        heading: workout.subtitle,
                        subHeading: 'Template',
                        alignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppLayout.p4),
                Row(
                  children: [
                    SquareButton(
                      onPressed: () => {},
                      label: 'Edit',
                      icon: Symbols.edit,
                      iconSize: 24,
                    ),
                    const SizedBox(width: AppLayout.p4),
                    SquareButton(
                      onPressed: () {},
                      label: 'Delete',
                      icon: Symbols.delete_outline,
                      iconSize: 24,
                    ),
                  ],
                ),
                const SizedBox(height: AppLayout.p4),
                Divider(
                  color: context.colors.divider,
                  height: 0,
                ),
                if (workout.description.isNotEmpty) ...[
                  const SizedBox(height: AppLayout.p4),
                  Text(
                    workout.description,
                    style: context.typography.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppLayout.p4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Row(
              children: [
                Expanded(
                  child: FlexButton(
                    onPressed: () {},
                    label: 'Start Workout',
                    backgroundColor: context.colors.backgroundTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
