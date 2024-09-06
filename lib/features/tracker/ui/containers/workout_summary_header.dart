import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flex_workout_mobile/features/tracker/ui/components/summary_highlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutSummaryHeader extends ConsumerWidget {
  const WorkoutSummaryHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(trackerFormControllerProvider);

    final totalMinutes = DateTime.now()
        .difference(form.model.startTimestamp ?? DateTime.now())
        .inMinutes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
      ],
    );
  }
}
