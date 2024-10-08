import 'package:flex_workout_mobile/features/exercise/controllers/exercise_create_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_form_controller.g.dart';

@riverpod
class ExerciseFormController extends _$ExerciseFormController {
  @override
  ExerciseForm build() {
    return ExerciseForm(ExerciseForm.formElements(const Exercise()), null);
  }

  void create() {
    ref.read(exerciseCreateControllerProvider.notifier).handle(state);
  }

  void autofillForm(ExerciseModel exercise) {
    final newValue = Exercise(
      general: General(
        name: exercise.name,
        description: exercise.description,
        videoUrl: exercise.videoUrl,
      ),
      advanced: Advanced(
        equipment: exercise.equipment,
        movementPattern: exercise.movementPattern,
        engagement: exercise.engagement,
      ),
      muscleGroups: MuscleGroups(
        primaryMuscleGroups: exercise.primaryMuscleGroups,
        secondaryMuscleGroups: exercise.secondaryMuscleGroups,
      ),
    );

    state.updateValue(newValue);
  }
}
