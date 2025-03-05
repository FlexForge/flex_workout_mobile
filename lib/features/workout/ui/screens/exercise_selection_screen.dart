import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/workout/ui/containers/exercise_selection_picker.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

final exerciseSelectionScreenObserver = NavigationSheetTransitionObserver();

class WorkoutExerciseSelectionScreenModal extends StatelessWidget {
  const WorkoutExerciseSelectionScreenModal({
    required this.nestedNavigator,
    super.key,
  });

  final Widget nestedNavigator;

  @override
  Widget build(BuildContext context) {
    return DraggableSheet(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: nestedNavigator,
      ),
    );
  }
}

class WorkoutExerciseSelectionScreen extends StatelessWidget {
  const WorkoutExerciseSelectionScreen({super.key});

  static const routePath = 'exercise_selection';
  static const routeName = 'workout_exercise_selection';

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: const WorkoutExerciseSelectionPicker(),
    );
  }
}
