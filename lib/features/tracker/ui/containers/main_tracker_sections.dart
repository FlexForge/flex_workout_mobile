import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/live_workout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainTrackerSections extends ConsumerWidget {
  const MainTrackerSections({required this.setState, super.key});

  final void Function(VoidCallback) setState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(liveWorkoutControllerProvider).sections;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sections.length,
      itemBuilder: (context, sectionIndex) {
        final section = sections[sectionIndex];

        return section.display();
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: AppLayout.p3,
      ),
    );
  }
}
