import 'package:flex_workout_mobile/core/utils/failure.dart';
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
}
