import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/workout/data/db/workout_entity.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:objectbox/objectbox.dart';

class WorkoutRepository {
  WorkoutRepository({required this.store});

  final Store store;

  Box<WorkoutEntity> get box => store.box<WorkoutEntity>();

  Either<Failure, List<WorkoutModel>> getWorkouts() {
    try {
      final res = box.getAll();
      return right(res.map((e) => e.toModel()).toList());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }

  Either<Failure, WorkoutModel> getWorkoutById(int id) {
    try {
      final res = box.get(id);

      if (res == null) {
        return left(
          const Failure.unprocessableEntity(message: 'Workout does not exist'),
        );
      }

      return right(res.toModel());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }
}
