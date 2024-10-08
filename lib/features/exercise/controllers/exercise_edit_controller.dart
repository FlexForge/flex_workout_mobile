import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_edit_controller.g.dart';

@riverpod
class ExerciseEditController extends _$ExerciseEditController {
  @override
  ExerciseModel build(String id) {
    final idAsInt = int.tryParse(id);

    if (idAsInt == null) {
      throw const Failure.unprocessableEntity(message: 'Id does not exist');
    }

    final res = ref.watch(exerciseRepositoryProvider).getExerciseById(idAsInt);
    return res.fold((l) => throw l, (r) => r);
  }

  void handle(ExerciseForm form, ExerciseModel originalExercise) {
    final generalModel = form.model.general;
    final advancedModel = form.model.advanced;
    final muscleGroupsModel = form.model.muscleGroups;

    final name = generalModel?.name;
    final description = generalModel?.description;
    final videoUrl = generalModel?.videoUrl;

    final movementPattern = advancedModel?.movementPattern;
    final engagement = advancedModel?.engagement;
    final equipment = advancedModel?.equipment;

    final primaryMuscleGroups = muscleGroupsModel?.primaryMuscleGroups;
    final secondaryMuscleGroups = muscleGroupsModel?.secondaryMuscleGroups;

    if (name == null) return;

    final res = ref.read(exerciseRepositoryProvider).updateExercise(
          originalExercise: originalExercise,
          name: name,
          description: description,
          videoUrl: videoUrl,
          engagement: engagement,
          equipment: equipment,
          movementPattern: movementPattern,
          primaryMuscleGroups: primaryMuscleGroups ?? [],
          secondaryMuscleGroups: secondaryMuscleGroups ?? [],
        );

    state = res.fold((l) => throw l, (r) => r);
  }
}
