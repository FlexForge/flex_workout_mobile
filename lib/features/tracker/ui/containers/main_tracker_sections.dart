import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/sections/default_section.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/sections/superset_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainTrackerSections extends ConsumerWidget {
  const MainTrackerSections({required this.setState, super.key});

  final void Function(VoidCallback) setState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(workoutControllerProvider).sections;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      itemBuilder: (context, sectionIndex) {
        final section = sections[sectionIndex];

        switch (section) {
          case final DefaultSectionModel obj:
            return DefaultSectionView(section: obj);
          case final SupersetSectionModel obj:
            return SupersetSectionView(section: obj);
        }
      },
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppLayout.p3),
    );
  }
}
