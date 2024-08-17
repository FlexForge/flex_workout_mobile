import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/drag_handle.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/main_tracker.dart'
    as main;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ResumeWorkoutBottomBar extends ConsumerWidget {
  const ResumeWorkoutBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(trackerFormControllerProvider);

    return TextButton(
      onPressed: () => showCupertinoModalBottomSheet<void>(
        context: context,
        useRootNavigator: true,
        barrierColor: context.colors.overlay,
        elevation: 0,
        builder: (context) => const Column(
          children: [
            DragHandle(),
            Expanded(child: main.Tracker()),
          ],
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: NoSplash.splashFactory,
        foregroundColor: context.colors.foregroundPrimary,
        backgroundColor: context.colors.backgroundSecondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppLayout.cornerRadius),
            topRight: Radius.circular(AppLayout.cornerRadius),
          ),
        ),
      ),
      child: ReactiveTrackerForm(
        form: form,
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppLayout.p4,
              vertical: AppLayout.p2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LargeButton(
                  onPressed: () {},
                  borderRadius: AppLayout.roundedRadius,
                  padding: const EdgeInsets.all(AppLayout.p2),
                  backgroundColor: context.colors.backgroundTertiary,
                  icon: Icons.close,
                ),
                ReactiveTrackerFormConsumer(
                  builder: (context, model, child) {
                    return Column(
                      children: [
                        Text(
                          model.model.title ?? 'Workout in Progress',
                          style: context.typography.labelLarge.copyWith(),
                        ),
                        Text(
                          form.model.startTimestamp?.toReadableDate() ??
                              'Jan 1, 2024',
                          style: context.typography.labelSmall.copyWith(
                            color: context.colors.foregroundSecondary,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                LargeButton(
                  icon: Symbols.resume,
                  iconSize: 24,
                  borderRadius: AppLayout.roundedRadius,
                  padding: EdgeInsets.zero,
                  disabledBackgroundColor: Colors.transparent,
                  disabledForegroundColor: context.colors.foregroundPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
