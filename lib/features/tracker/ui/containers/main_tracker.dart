import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/components/tracker_bottom_bar.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/tracked_workout_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Tracker extends ConsumerStatefulWidget {
  const Tracker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrackerState();
}

class _TrackerState extends ConsumerState<Tracker> {
  @override
  void initState() {
    final exists = ref.exists(trackerFormControllerProvider);

    if (!exists) {
      ref.read(trackerFormControllerProvider.notifier).fillNewEmptyWorkout();
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(trackerFormControllerProvider);

    return ReactiveTrackerForm(
      form: form,
      child: Scaffold(
        backgroundColor: context.colors.backgroundPrimary,
        bottomNavigationBar: const TrackerBottomBar(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Row(
              children: [
                Text(
                  form.model.subtitle ?? 'Day 3',
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  form.model.startTimestamp?.toReadableDate() ?? 'Jan 1, 2024',
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppLayout.p2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: Text(
                'Temp Workout Name',
                style: context.typography.headlineLarge
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: AppLayout.p6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: LargeButton(
                onPressed: () => showCupertinoModalBottomSheet<void>(
                  context: context,
                  useRootNavigator: true,
                  barrierColor: context.colors.overlay,
                  elevation: 0,
                  builder: (context) => Container(),
                ),
                expanded: true,
                label: 'Add Exercise',
                icon: Symbols.add,
                backgroundColor: context.colors.backgroundSecondary,
              ),
            ),
            const SizedBox(height: AppLayout.p6),
            Divider(
              color: context.colors.divider,
              height: 0,
            ),
            const SizedBox(height: AppLayout.p6),
            const TrackedWorkoutSummary()
          ],
        ),
      ),
    );
  }
}
