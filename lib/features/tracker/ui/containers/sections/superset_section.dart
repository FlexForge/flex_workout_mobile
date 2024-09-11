import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/live_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/current_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/components/swipe_action_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:material_symbols_icons/symbols.dart';

class SupersetSectionView extends ConsumerWidget {
  const SupersetSectionView({required this.section, super.key});

  final LiveSupersetSectionModel section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void addSet(LiveSupersetSectionModel sectionIndex) {
      ref.read(liveWorkoutControllerProvider.notifier).addSet(section);
    }

    return SwipeActionCell(
      key: ObjectKey(section.hashCode),
      backgroundColor: context.colors.backgroundPrimary,
      trailingActions: [
        SwipeAction(
          content: SwipeActionCircle(
            color: context.colors.red,
            icon: Symbols.delete,
          ),
          color: Colors.transparent,
          widthSpace: 64,
          onTap: (handler) async {
            // await handler(true);
            // ref
            //     .read(currentWorkoutControllerProvider.notifier)
            //     .removeSection(sectionIndex);
          },
        ),
      ],
      child: Section(
        header: section.title,
        subHeader: 'Working Sets',
        padding: const EdgeInsets.only(
          left: AppLayout.p4,
          right: AppLayout.p4,
          bottom: AppLayout.p3,
        ),
        body: Column(
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: section.sets.length,
              itemBuilder: (context, setIndex) {
                final set = section.sets[setIndex];

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: set.length,
                  separatorBuilder: (context, index) => Divider(
                    indent: 54,
                    height: 0,
                    color: context.colors.divider,
                  ),
                  itemBuilder: (context, exerciseIndex) {
                    final key = String.fromCharCode(65 + exerciseIndex);
                    final superSet = set[key];

                    if (superSet == null) return const Text('Error');

                    return SwipeActionCell(
                      key: ObjectKey(
                        '${superSet.sectionIndex}${superSet.hashCode}',
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
                            // ref
                            //     .read(currentWorkoutControllerProvider.notifier)
                            //     .removeSuperSet(
                            //         sectionIndex, organizerIndex, setIndex);
                          },
                          color: context.colors.red,
                        ),
                      ],
                      child: superSet.display(),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(height: 0, color: context.colors.divider),
            ),
            if (section.sets.isNotEmpty)
              Divider(height: 0, color: context.colors.divider),
            const SizedBox(height: AppLayout.p4),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppLayout.p4,
              ),
              child: LargeButton(
                onPressed: () => addSet(section),
                expanded: true,
                label: 'Add Set',
                icon: Symbols.add,
                backgroundColor: context.colors.backgroundTertiary,
                foregroundColor: context.colors.foregroundPrimary,
              ),
            ),
            const SizedBox(height: AppLayout.p4),
          ],
        ),
      ),
    );
  }
}
