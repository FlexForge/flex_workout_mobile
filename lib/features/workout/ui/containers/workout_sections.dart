import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutSections extends ConsumerWidget {
  const WorkoutSections({required this.model, super.key});

  final WorkoutModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = model.sections;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      itemBuilder: (context, sectionIndex) {
        final section = sections[sectionIndex];

        return section.display();
      },
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppLayout.p3),
    );
  }
}
