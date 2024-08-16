import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tracker extends ConsumerStatefulWidget {
  const Tracker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrackerState();
}

class _TrackerState extends ConsumerState<Tracker> {
  @override
  void initState() {
    ref.read(trackerFormControllerProvider.notifier).fillNewEmptyWorkout();

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Row(
              children: [
                Text(
                  form.model.subtitle ?? 'Day 3',
                  style: context.typography.labelSmall.copyWith(
                    color: context.colors.foregroundSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  form.model.startTimestamp?.toReadableDate() ?? 'Jan 1, 2024',
                  style: context.typography.labelSmall.copyWith(
                    color: context.colors.foregroundSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const Column(
          children: [Text('Test')],
        ),
      ),
    );
  }
}
