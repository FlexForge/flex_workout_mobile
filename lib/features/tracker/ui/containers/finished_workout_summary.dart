import 'package:flex_workout_mobile/core/common/controllers/app_controller.dart';
import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracked_workout_create_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/components/summary_highlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class FinishedWorkoutSummary extends ConsumerWidget {
  const FinishedWorkoutSummary({required this.back, super.key});

  final VoidCallback back;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(trackerFormControllerProvider);

    final totalMinutes = DateTime.now()
        .difference(form.model.startTimestamp ?? DateTime.now())
        .inMinutes;

    void logWorkout() {
      ref
          .read(trackedWorkoutCreateControllerProvider.notifier)
          .handle(form, totalMinutes);

      ref.invalidate(trackerFormControllerProvider);
      ref.read(appControllerProvider.notifier).endWorkout();
    }

    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(39),
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppLayout.p4,
            right: AppLayout.p4,
            bottom: AppLayout.p2,
          ),
          child: Row(
            children: [
              Text(
                form.model.title ?? 'Workout Summary',
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
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          color: context.colors.backgroundSecondary,
          padding: EdgeInsets.zero,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LargeButton(
                  onPressed: back,
                  icon: Symbols.chevron_left,
                  backgroundColor: context.colors.backgroundTertiary,
                ),
                const SizedBox(width: AppLayout.p2),
                Expanded(
                  child: LargeButton(
                    onPressed: logWorkout,
                    label: 'Log Workout',
                    icon: Symbols.add_task,
                    backgroundColor: context.colors.foregroundPrimary,
                    foregroundColor: context.colors.backgroundPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        primary: false,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Text(
              'You crushed it!',
              style: context.typography.headlineLarge
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: AppLayout.p6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SummaryHighlight(
                  diameter: 110,
                  color: context.colors.blue,
                  value: '0',
                  label: 'lbs',
                ),
                const Spacer(),
                SummaryHighlight(
                  diameter: 110,
                  color: context.colors.yellow,
                  value: '0',
                  label: 'sets',
                ),
                const Spacer(),
                SummaryHighlight(
                  diameter: 110,
                  color: context.colors.green,
                  value: totalMinutes.toString(),
                  label: 'minutes',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppLayout.p4),
          Divider(
            color: context.colors.divider,
            height: 0,
          ),
          const SizedBox(height: AppLayout.p6),
          Section(
            header: 'Overview',
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppLayout.p6),
              child: Center(
                child: Text(
                  'No exercises recorded',
                  style: context.typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colors.foregroundSecondary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppLayout.p3),
          Section(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppLayout.p6),
              child: Center(
                child: Text(
                  'No muscles targeted',
                  style: context.typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.colors.foregroundSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
