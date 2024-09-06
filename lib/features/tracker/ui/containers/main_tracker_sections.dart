import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_section_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/components/swipe_action_circle.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/set_tiles/default_set_tile.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/set_tiles/super_set_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fpdart/fpdart.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class MainTrackerSections extends ConsumerWidget {
  const MainTrackerSections({required this.setState, super.key});

  final void Function(VoidCallback) setState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(trackerFormControllerProvider);

    void addSet(TrackedWorkoutSectionForm section) {
      ref.read(trackerFormControllerProvider.notifier).addDefaultSet(section);
      setState(() {});
    }

    return ReactiveFormArray(
      formArray: form.sectionsControl,
      builder: (context, formArray, child) {
        final sections = form.sectionsTrackedWorkoutSectionForm
            .mapWithIndex((section, index) {
          return Section(
            header: section.model.title,
            subHeader: 'Working Sets',
            padding: const EdgeInsets.only(
              left: AppLayout.p4,
              right: AppLayout.p4,
              // top: AppLayout.p6,
              bottom: AppLayout.p3,
            ),
            body: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: section.organizersTrackedSetOrganizerForm.length,
                  itemBuilder: (context, index) {
                    final organizer =
                        section.organizersTrackedSetOrganizerForm[index];

                    switch (organizer.model.organization) {
                      case SetOrganizationEnum.defaultSet:
                        return DefaultSetTile(
                          sectionForm: section,
                          organizerForm: organizer,
                          index: index,
                          setState: setState,
                        );
                      case SetOrganizationEnum.superSet:
                        return SuperSetTile(
                          sectionForm: section,
                          organizerForm: organizer,
                          index: index,
                          setState: setState,
                        );
                    }
                  },
                  separatorBuilder: (context, index) {
                    final organization = section
                        .organizersTrackedSetOrganizerForm[index]
                        .model
                        .organization;

                    return Divider(
                      indent:
                          organization == SetOrganizationEnum.superSet ? 0 : 54,
                      height: 0,
                      color: context.colors.divider,
                    );
                  },
                ),
                if (section.organizersTrackedSetOrganizerForm.isNotEmpty)
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
          );
        }).toList();

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sections.length,
          itemBuilder: (context, index) => SwipeActionCell(
            key: ObjectKey(sections[index].hashCode),
            backgroundColor: context.colors.backgroundPrimary,
            trailingActions: [
              SwipeAction(
                content: SwipeActionCircle(
                  color: context.colors.red,
                  icon: Symbols.delete,
                ),
                color: Colors.transparent,
                widthSpace: 64,
                onTap: (handler) async => {
                  await handler(true),
                  ref
                      .read(trackerFormControllerProvider.notifier)
                      .removeSection(index),
                },
              ),
            ],
            child: sections[index],
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: AppLayout.p3,
          ),
        );
      },
    );
  }
}
