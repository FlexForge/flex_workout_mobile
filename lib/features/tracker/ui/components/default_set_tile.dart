import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:material_symbols_icons/symbols.dart';

class DefaultSetTile extends ConsumerWidget {
  const DefaultSetTile({
    required this.sectionForm,
    required this.organizerForm,
    required this.index,
    required this.setState,
    super.key,
  });

  final TrackedWorkoutSectionForm sectionForm;
  final TrackedSetOrganizerForm organizerForm;
  final int index;

  final void Function(VoidCallback) setState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwipeActionCell(
      key: ObjectKey(organizerForm.hashCode),
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
                .read(trackerFormControllerProvider.notifier)
                .removeDefaultSet(sectionForm, index);
            setState(() {});
          },
          color: context.colors.red,
        ),
      ],
      child: FlexListTile(
        onTap: () {},
        prefix: Center(
          child: Text(
            '${organizerForm.model.setNumber}',
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
          'Normal Set',
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
  }
}
