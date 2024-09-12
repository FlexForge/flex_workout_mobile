import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/live_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/current_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/normal_set_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class DefaultSetTile extends ConsumerWidget {
  const DefaultSetTile({required this.set, super.key});

  final LiveDefaultSetModel set;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deleteSet() {
      ref.read(liveWorkoutControllerProvider.notifier).removeDefaultSet(set);
    }

    return SwipeActionCell(
      key: ObjectKey(set.hashCode),
      backgroundColor: context.colors.backgroundSecondary,
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
      child: set.isComplete ? _Completed(set: set) : _Incomplete(set: set),
    );
  }
}

class _Completed extends StatelessWidget {
  const _Completed({required this.set});

  final LiveDefaultSetModel set;

  @override
  Widget build(BuildContext context) {
    return FlexListTile(
      onTap: () => context.goNamed(NormalSetScreen.routeName, extra: set),
      prefix: Center(
        child: Text(
          '${set.setIndex + 1}${set.setString}',
          style: context.typography.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.foregroundTertiary,
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            '${set.load} ${set.units?.name}',
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundTertiary,
            ),
          ),
          const SizedBox(width: AppLayout.p1),
          Icon(
            Symbols.close,
            size: 12,
            weight: 900,
            color: context.colors.foregroundQuaternary,
          ),
          const SizedBox(width: AppLayout.p1),
          Text(
            '${set.reps} reps',
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundTertiary,
            ),
          ),
        ],
      ),
      subtitle: Text(
        'Extra notes here',
        style: context.typography.bodySmall.copyWith(
          fontWeight: FontWeight.w500,
          color: context.colors.foregroundQuaternary,
        ),
      ),
      suffixPadding: const EdgeInsets.only(right: AppLayout.p4),
      suffix: LargeButton(
        label: 'Complete',
        icon: Symbols.done_all,
        iconSize: 16,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.p4,
          vertical: AppLayout.p1,
        ),
        disabledForegroundColor: context.colors.foregroundTertiary,
        disabledBackgroundColor: context.colors.backgroundTertiary,
      ),
    );
  }
}

class _Incomplete extends StatelessWidget {
  const _Incomplete({required this.set});

  final LiveDefaultSetModel set;

  @override
  Widget build(BuildContext context) {
    return FlexListTile(
      onTap: () => context.goNamed(NormalSetScreen.routeName, extra: set),
      prefix: Center(
        child: Text(
          '${set.setIndex + 1}${set.setString}',
          style: context.typography.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.foregroundPrimary,
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            '--',
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundPrimary,
            ),
          ),
          Text(
            ' lbs',
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundSecondary,
            ),
          ),
          const SizedBox(width: AppLayout.p1),
          Icon(
            Symbols.close,
            size: 12,
            weight: 900,
            color: context.colors.foregroundTertiary,
          ),
          const SizedBox(width: AppLayout.p1),
          Text(
            '--',
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundPrimary,
            ),
          ),
          Text(
            ' reps',
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundSecondary,
            ),
          ),
        ],
      ),
      subtitle: Text(
        set.exercise.name,
        overflow: TextOverflow.ellipsis,
        style: context.typography.bodySmall.copyWith(
          fontWeight: FontWeight.w500,
          color: context.colors.foregroundTertiary,
        ),
      ),
      suffixPadding: const EdgeInsets.only(right: AppLayout.p4),
      suffix: LargeButton(
        label: 'Log set',
        icon: Symbols.edit,
        iconSize: 16,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.p4,
          vertical: AppLayout.p1,
        ),
        disabledForegroundColor: context.colors.foregroundPrimary,
        disabledBackgroundColor: context.colors.backgroundTertiary,
      ),
    );
  }
}
