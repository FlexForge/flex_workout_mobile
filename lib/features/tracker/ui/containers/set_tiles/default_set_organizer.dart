import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/current_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/current_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/set_tiles/normal_set_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class DefaultSetOrganizer extends ConsumerWidget {
  const DefaultSetOrganizer({
    required this.sectionIndex,
    required this.organizerIndex,
    required this.organizer,
    required this.setState,
    super.key,
  });

  final int sectionIndex;
  final int organizerIndex;
  final CurrentWorkoutOrganizer organizer;
  final void Function(VoidCallback) setState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwipeActionCell(
      key: ObjectKey(organizer.hashCode),
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
          onTap: (CompletionHandler handler) async {
            await handler(true);
            ref
                .read(currentWorkoutControllerProvider.notifier)
                .removeDefaultSet(sectionIndex, organizerIndex);
          },
          color: context.colors.red,
        ),
      ],
      child: NormalSetTile(
        setType: organizer.defaultSet,
        prefix: '${organizer.setNumber}',
      ),
    );
  }
}
