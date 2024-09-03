import 'package:flex_workout_mobile/core/common/controllers/app_controller.dart';
import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/tracked_workout_summary.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/tracker_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class Tracker extends ConsumerStatefulWidget {
  const Tracker({required this.next, super.key});

  final VoidCallback next;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrackerState();
}

class _TrackerState extends ConsumerState<Tracker> {
  @override
  void initState() {
    final workoutInProgress = ref.read(appControllerProvider).workoutInProgress;

    if (!workoutInProgress) {
      Future(() {
        ref.read(appControllerProvider.notifier).startWorkout();
      });

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
        bottomNavigationBar: TrackerBottomBar(next: widget.next),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppLayout.p4,
              right: AppLayout.p4,
              bottom: AppLayout.p2,
            ),
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
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          primary: false,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: FlexTextField(
                formControl: form.titleControl,
                inputAction: TextInputAction.done,
                inputType: TextInputType.name,
                hintText: 'Workout Name',
                contentPadding: EdgeInsets.zero,
                style: context.typography.headlineLarge
                    .copyWith(fontWeight: FontWeight.w700),
                suffix: Icon(
                  Symbols.edit,
                  size: 20,
                  weight: 700,
                  color: context.colors.foregroundSecondary,
                ),
                enableBorder: false,
                isRequired: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: FlexTextField(
                formControl: form.notesControl,
                inputAction: TextInputAction.done,
                inputType: TextInputType.name,
                isTextArea: true,
                minLines: 1,
                hintText: 'Notes',
                contentPadding: EdgeInsets.zero,
                style: context.typography.bodyMedium.copyWith(
                  color: context.colors.foregroundSecondary,
                ),
                enableBorder: false,
                isRequired: true,
              ),
            ),
            const SizedBox(height: AppLayout.p6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: LargeButton(
                onPressed: () => {},
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
            const TrackedWorkoutSummary(),
          ],
        ),
      ),
    );
  }
}
