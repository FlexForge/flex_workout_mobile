import 'dart:async';

import 'package:flex_workout_mobile/core/common/ui/components/stacked_text.dart';
import 'package:flex_workout_mobile/core/common/ui/components/text_with_color.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TrackedWorkoutSummary extends ConsumerStatefulWidget {
  const TrackedWorkoutSummary({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TrackedWorkoutSummaryState();
}

class _TrackedWorkoutSummaryState extends ConsumerState<TrackedWorkoutSummary> {
  String _timeString = "";
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeString = DateFormat('s').format(DateTime.now());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(trackerFormControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: Text(
            'Workout Summary',
            style: context.typography.headlineMedium
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: AppLayout.p4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: LayoutGrid(
            columnSizes: [1.fr, 1.fr, 1.fr],
            rowSizes: const [auto, auto],
            rowGap: AppLayout.p4, // equivalent to mainAxisSpacing
            columnGap: AppLayout.p4,
            children: [
              TextWithColor(
                color: context.colors.blue,
                label: 'Total volume',
                value: '0',
                isLarge: true,
              ),
              TextWithColor(
                color: context.colors.green,
                label: 'Sets completed',
                value: '0',
                isLarge: true,
              ),
              TextWithColor(
                color: context.colors.yellow,
                label: 'Reps completed',
                value: '0',
                isLarge: true,
              ),
              StackedText(
                heading: form.model.startTimestamp?.toReadableTime() ?? '',
                subHeading: 'Start Time',
                alignment: CrossAxisAlignment.start,
              ),
              StackedText(
                heading: _timeString,
                subHeading: 'Workout length',
                alignment: CrossAxisAlignment.start,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppLayout.p4),
      ],
    );
  }
}