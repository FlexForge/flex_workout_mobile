import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/history/ui/containers/sections/default_section.dart';
import 'package:flex_workout_mobile/features/history/ui/containers/sections/superset_section.dart';
import 'package:flutter/material.dart';

class HistoricWorkoutOverview extends StatelessWidget {
  const HistoricWorkoutOverview({required this.workout, super.key});

  final HistoricWorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: workout.sections.length,
      itemBuilder: (context, index) {
        final section = workout.sections[index];

        switch (section) {
          case final HistoricDefaultSectionModel obj:
            return HistoricWorkoutDefaultSection(section: obj, index: index);
          case final HistoricSupersetSectionModel obj:
            return HistoricWorkoutSupersetSection(section: obj, index: index);
        }
      },
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppLayout.p3),
    );
  }
}
