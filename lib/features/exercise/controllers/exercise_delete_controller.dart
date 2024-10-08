import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_delete_controller.g.dart';

@riverpod
class ExerciseDeleteController extends _$ExerciseDeleteController {
  @override
  bool build(ExerciseModel exercise) {
    return false;
  }

  void handle() {
    final res =
        ref.read(exerciseRepositoryProvider).deleteExercise(id: exercise.id);

    state = res.fold((l) => throw l, (r) => r);
  }
}
