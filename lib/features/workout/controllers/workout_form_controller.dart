import 'package:flex_workout_mobile/features/workout/controllers/workout_create_controller.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_form_model.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_form_controller.g.dart';

@riverpod
class WorkoutFormController extends _$WorkoutFormController {
  @override
  WorkoutForm build() {
    return WorkoutForm(WorkoutForm.formElements(const Workout()), null);
  }

  void create() {
    ref.read(workoutCreateControllerProvider.notifier).handle(state);
  }

  // TODO: workout edit
  // void update(WorkoutModel workout) {
  //   ref
  //       .read(workoutEditControllerProvider(workout.id.toString()).notifier)
  //       .handle(state, workout);
  // }

  void autofillForm(WorkoutModel workout) {
    final newValue = Workout(
      general: General(
        name: workout.title,
        description: workout.description,
      ),
      exercises: Exercises(
        sections: workout.sections,
      ),
    );

    state.updateValue(newValue);
  }
}
