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

  void handle(WorkoutForm form, WorkoutModel model) {
    final generalModel = form.model.general;

    final title = generalModel?.name;
    final subtitle = generalModel?.focus;
    final description = generalModel?.description;

    if (title == null || subtitle == null) return;

    final res = ref.read(workoutRepositoryProvider).createWorkout(
          sections: model.sections,
          title: title,
          subtitle: subtitle,
          primaryMuscleGroups: model.primaryMuscleGroups,
          secondaryMuscleGroups: model.secondaryMuscleGroups,
          description: description,
        );

    state = res.fold((l) => throw l, (r) => r);
  }
}
