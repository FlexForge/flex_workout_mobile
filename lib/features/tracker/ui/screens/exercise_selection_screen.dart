import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/exercise_selection_picker.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

final exerciseSelectionScreenObserver = NavigationSheetTransitionObserver();

class ExerciseSelectionScreenModal extends StatelessWidget {
  const ExerciseSelectionScreenModal({
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

class ExerciseSelectionScreen extends StatelessWidget {
  const ExerciseSelectionScreen({super.key});

  static const routePath = 'exercise_selection';
  static const routeName = 'tracker_exercise_selection';

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: const ExerciseSelectionPicker(),
    );
  }
}
