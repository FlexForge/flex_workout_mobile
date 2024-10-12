import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_alert_dialog.dart';
import 'package:flex_workout_mobile/core/common/ui/components/icon_text_display.dart';
import 'package:flex_workout_mobile/core/common/ui/components/stacked_text.dart';
import 'package:flex_workout_mobile/core/extensions/num_extensions.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_delete_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_edit_screen.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/video_demo_screen.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/sets/default_set_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class HistoricWorkoutSummary extends ConsumerWidget {
  const HistoricWorkoutSummary({required this.workout, super.key});

  final HistoricWorkoutModel workout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = workout.endTimestamp.difference(workout.startTimestamp);

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
                    const Expanded(
                      child: StackedText(
                        heading: 'Quick Start',
                        subHeading: 'Workout',
                        alignment: CrossAxisAlignment.start,
                      ),
                    ),
                    StackedText(
                      heading: workout.volume.cleanNumber(),
                      subHeading: 'Volume',
                      suffix: 'lb',
                    ),
                    const SizedBox(width: AppLayout.p4),
                    StackedText(
                      heading: duration.inMinutes.toString(),
                      subHeading: 'Minutes',
                      // alignment: CrossAxisAlignment.end,
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
                if (workout.notes.isNotEmpty) ...[
                  const SizedBox(height: AppLayout.p4),
                  Text(
                    workout.notes,
                    style: context.typography.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
