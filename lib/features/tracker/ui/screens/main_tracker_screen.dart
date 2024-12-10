import 'package:flex_workout_mobile/core/common/controllers/app_controller.dart';
import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/main_tracker_app_bar.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/main_tracker_bottom_bar.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/main_tracker_header.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/main_tracker_sections.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/main_tracker_summary.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/exercise_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainTrackerScreen extends ConsumerStatefulWidget {
  const MainTrackerScreen({required this.next, super.key});

  final VoidCallback next;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainTrackerScreenState();
}

class _MainTrackerScreenState extends ConsumerState<MainTrackerScreen> {
  @override
  void initState() {
    final workoutInProgress = ref.read(appControllerProvider).workoutInProgress;

    if (!workoutInProgress) {
      Future(() {
        ref.read(appControllerProvider.notifier).startWorkout();
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MainTrackerAppBar(),
        Expanded(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const MainTrackerHeader(),
              const SizedBox(height: AppLayout.p4),
              MainTrackerSections(setState: setState),
              const SizedBox(height: AppLayout.p3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
                child: FlexButton(
                  onPressed: () =>
                      context.goNamed(ExerciseSelectionScreen.trackerRouteName),
                  expanded: true,
                  label: 'Add Exercise',
                  icon: Symbols.add,
                  backgroundColor: context.colors.backgroundSecondary,
                ),
              ),
              const SizedBox(height: AppLayout.p6),
              Divider(color: context.colors.divider, height: 0),
              const SizedBox(height: AppLayout.p6),
              const MainTrackerSummary(),
              const SizedBox(height: AppLayout.bottomBuffer),
            ],
          ),
        ),
        MainTrackerBottomBar(next: widget.next),
      ],
    );
  }
}
