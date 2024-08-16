import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:fpdart/fpdart.dart';

class ExerciseRepository {
  ExerciseRepository({required this.store});
  final Store store;

  Box<Exercise> get box => store.box<Exercise>();

  Either<Failure, List<ExerciseModel>> getExercises() {
    try {
      final res = box.getAll();

      return right(res.map((e) => e.toModel()).toList());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }

  Either<Failure, ExerciseModel> getExerciseById(int id) {
    try {
      final res = box.get(id);

      if (res == null) {
        return left(
          const Failure.unprocessableEntity(message: 'Exercise does not exist'),
        );
      }

      return right(res.toModel());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }
}
