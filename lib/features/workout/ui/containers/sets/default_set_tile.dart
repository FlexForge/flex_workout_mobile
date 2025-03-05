import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_controller.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flex_workout_mobile/features/workout/ui/screens/normal_set_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class WorkoutDefaultSetTile extends ConsumerWidget {
  const WorkoutDefaultSetTile({required this.set, super.key});

  final WorkoutDefaultSetModel set;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deleteSet() {
      ref.read(workoutControllerProvider.notifier).removeDefaultSet(set);
    }

    return SwipeActionCell(
      key: ObjectKey(set.hashCode),
      backgroundColor: context.colors.backgroundTertiary,
      trailingActions: <SwipeAction>[
        SwipeAction(
          title: 'Delete',
          performsFirstActionWithFullSwipe: true,
          icon: const Icon(
            Icons.delete,
            size: 20,
          ),
          style: context.typography.labelSmall,
          onTap: (handler) async {
            await handler(true);
            deleteSet();
          },
          color: context.colors.red,
        ),
      ],
      child: _Exercise(set: set)
      // set.exercise != null ? _Exercise(set: set) :
      // set.movementPattern != null ? _MovementPattern(set: set) :
      // set.muscleGroup != null ? _MuscleGroup(set: set) : Container()
      ,
    );
  }
}

class _Exercise extends StatelessWidget {
  const _Exercise({required this.set});

  final WorkoutDefaultSetModel set;

  @override
  Widget build(BuildContext context) {
    return FlexListTile(
      onTap: () =>
          context.goNamed(WorkoutNormalSetScreen.routeName, extra: set),
      prefix: Center(
        child: Text(
          '${set.setIndex! + 1}${set.setString}',
          style: context.typography.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.foregroundSecondary,
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            set.minReps.toString(),
            style: context.typography.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundPrimary,
            ),
          ),
          if (set.maxReps != null) ...[
            Text(
              '-${set.maxReps}',
              style: context.typography.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colors.foregroundPrimary,
              ),
            ),
          ],
          Text(
            ' rep${set.minReps != 1 || set.maxReps != null ? 's' : ''}',
            style: context.typography.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundSecondary,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Container(),
        ],
      ),
      suffixPadding: const EdgeInsets.only(right: AppLayout.p4),
      suffix: FlexButton(
        label: 'Edit set',
        icon: Symbols.edit,
        iconSize: 16,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.p4,
          vertical: AppLayout.p1,
        ),
        disabledForegroundColor: context.colors.foregroundPrimary,
        disabledBackgroundColor: context.colors.backgroundQuaternary,
      ),
    );
  }
}

// TODO: Movement pattern tile

// TODO: Muscle group tile
