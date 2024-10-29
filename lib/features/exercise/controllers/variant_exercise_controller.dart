import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'variant_exercise_controller.g.dart';

@riverpod
class VariantExerciseController extends _$VariantExerciseController {
  @override
  List<ExerciseModel> build(ExerciseModel exercise) {
    final res =
        ref.watch(exerciseRepositoryProvider).getVariantExercises(exercise);

    return res.fold((l) => throw l, (r) => r);
  }
}
