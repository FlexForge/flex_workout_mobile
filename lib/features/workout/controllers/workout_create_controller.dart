import 'package:flex_workout_mobile/features/workout/data/models/workout_form_model.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flex_workout_mobile/features/workout/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_create_controller.g.dart';

@riverpod
class WorkoutCreateController extends _$WorkoutCreateController {
  @override
  WorkoutModel? build() {
    return null;
  }

  void handle(WorkoutForm form) {
    final generalModel = form.model.general;
    final exercisesModel = form.model.exercises;

    final title = generalModel?.name;
    final subtitle = generalModel?.focus;
    final description = generalModel?.description;

    ///

    final sections = exercisesModel?.sections ?? [];

    final primaryMuscleGroups = exercisesModel?.primaryMuscleGroups ?? [];
    final secondaryMuscleGroups = exercisesModel?.secondaryMuscleGroups ?? [];

    if (title == null || subtitle == null) return;

    final res = ref.read(workoutRepositoryProvider).createWorkout(
          sections: sections,
          title: title,
          subtitle: subtitle,
          primaryMuscleGroups: primaryMuscleGroups,
          secondaryMuscleGroups: secondaryMuscleGroups,
          description: description,
        );

    state = res.fold((l) => throw l, (r) => r);
  }
}
