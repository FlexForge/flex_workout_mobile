import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_view_controller.g.dart';

@riverpod
class ExerciseViewController extends _$ExerciseViewController {
  @override
  ExerciseModel build(String id) {
    final exerciseId = int.tryParse(id);
    if (exerciseId == null) throw const Failure.badRequest();

    final res =
        ref.watch(exerciseRepositoryProvider).getExerciseById(exerciseId);

    return res.fold(
      (l) => throw l,
      (r) => r,
    );
  }
}
