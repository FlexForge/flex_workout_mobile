import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/components/swipe_action_circle.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/sets/default_set_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:material_symbols_icons/symbols.dart';

class DefaultSectionView extends ConsumerWidget {
  const DefaultSectionView({required this.section, super.key});

  final DefaultSectionModel section;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void addSet() {
      ref.read(workoutControllerProvider.notifier).addDefaultSet(section);
    }

    void deleteSection() {
      ref.read(workoutControllerProvider.notifier).removeSection(section);
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
            await handler(true);
            deleteSection();
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

                switch (set) {
                  case final DefaultSetModel obj:
                    return DefaultSetTile(set: obj);
                }
                // return set.display();
              },
              separatorBuilder: (context, index) =>
                  Divider(indent: 54, height: 0, color: context.colors.divider),
            ),
            if (section.sets.isNotEmpty)
              Divider(height: 0, color: context.colors.divider),
            const SizedBox(height: AppLayout.p4),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppLayout.p4,
              ),
              child: FlexButton(
                onPressed: addSet,
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
