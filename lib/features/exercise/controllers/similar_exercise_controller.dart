import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'similar_exercise_controller.g.dart';

@riverpod
class SimilarExerciseController extends _$SimilarExerciseController {
  @override
  List<ExerciseModel> build(ExerciseModel exercise) {
    final res =
        ref.watch(exerciseRepositoryProvider).getSimilarExercises(exercise);

    final models = res.fold((l) => throw l, (r) => r);

    final filteredExercises =
        models.where((e) => e.baseExercise?.id != exercise.id).toList();

    return filteredExercises;
  }
}
