import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/current_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/current_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:material_symbols_icons/symbols.dart';

class SuperSetTile extends ConsumerWidget {
  const SuperSetTile({
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
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: organizer.superSet.length,
      separatorBuilder: (context, index) => Divider(
        indent: 54,
        height: 0,
        color: context.colors.divider,
      ),
      itemBuilder: (context, setIndex) {
        final superSet = organizer.superSet[setIndex];

        return SwipeActionCell(
          key: ObjectKey(
            '${organizer.setNumber}${superSet.hashCode}',
          ),
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
                    .removeSuperSet(sectionIndex, organizerIndex, setIndex);
              },
              color: context.colors.red,
            ),
          ],
          child: FlexListTile(
            onTap: () {},
            prefix: Center(
              child: Text(
                '${organizer.setNumber}${superSet.setLetter}',
                style: context.typography.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: '--',
                style: context.typography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' lbs',
                    style: context.typography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colors.foregroundSecondary,
                    ),
                  ),
                  TextSpan(
                    text: ' x --',
                    style: context.typography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: ' reps',
                    style: context.typography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colors.foregroundSecondary,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              superSet.exercise.name,
              overflow: TextOverflow.ellipsis,
              style: context.typography.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colors.foregroundSecondary,
              ),
            ),
            suffixPadding: const EdgeInsets.only(right: AppLayout.p4),
            suffix: LargeButton(
              onPressed: () {},
              label: 'Log set',
              icon: Symbols.edit,
              iconSize: 16,
              padding: const EdgeInsets.symmetric(
                horizontal: AppLayout.p4,
                vertical: AppLayout.p1,
              ),
              backgroundColor: context.colors.backgroundTertiary,
            ),
          ),
        );
      },
    );
  }
}
