import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/current_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/components/swipe_action_circle.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/set_tiles/default_set_tile.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/set_tiles/super_set_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainTrackerSections extends ConsumerWidget {
  const MainTrackerSections({required this.setState, super.key});

  final void Function(VoidCallback) setState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(currentWorkoutControllerProvider).sections;

    void addSet(int sectionIndex) {
      ref.read(currentWorkoutControllerProvider.notifier).addSet(sectionIndex);
      setState(() {});
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      itemBuilder: (context, sectionIndex) {
        final section = sections[sectionIndex];

        return SwipeActionCell(
          key: ObjectKey(sections[sectionIndex].hashCode),
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
                ref
                    .read(currentWorkoutControllerProvider.notifier)
                    .removeSection(sectionIndex);
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
                  itemCount: section.organizers.length,
                  itemBuilder: (context, organizerIndex) {
                    final organizer = section.organizers[organizerIndex];
                    switch (organizer.organization) {
                      case SetOrganizationEnum.defaultSet:
                        return DefaultSetTile(
                          sectionIndex: sectionIndex,
                          organizerIndex: organizerIndex,
                          organizer: organizer,
                          setState: setState,
                        );
                      case SetOrganizationEnum.superSet:
                        return SuperSetTile(
                          sectionIndex: sectionIndex,
                          organizerIndex: organizerIndex,
                          organizer: organizer,
                          setState: setState,
                        );
                    }
                  },
                  separatorBuilder: (context, index) {
                    final organization = section.organizers[index].organization;

                    return Divider(
                      indent:
                          organization == SetOrganizationEnum.superSet ? 0 : 54,
                      height: 0,
                      color: context.colors.divider,
                    );
                  },
                ),
                if (section.organizers.isNotEmpty)
                  Divider(
                    height: 0,
                    color: context.colors.divider,
                  ),
                const SizedBox(height: AppLayout.p4),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppLayout.p4,
                  ),
                  child: LargeButton(
                    onPressed: () => addSet(sectionIndex),
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
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: AppLayout.p3,
      ),
    );
  }
}
