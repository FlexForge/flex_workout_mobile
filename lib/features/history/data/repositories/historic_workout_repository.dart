import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/history/data/db/historic_workout_entity.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/live_workout_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:objectbox/objectbox.dart';

class HistoricWorkoutRepository {
  HistoricWorkoutRepository({required this.store});

  final Store store;

  Box<HistoricWorkoutEntity> get box => store.box<HistoricWorkoutEntity>();

  Either<Failure, List<HistoricWorkoutModel>> getHistoricWorkouts() {
    try {
      final res = box.get(3);

      // final models = res.map((e) => e.toModel()).toList();

      return right([res!.toModel()]);
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }

  Either<Failure, HistoricWorkoutModel> createdHistoricWorkout({
    required String title,
    required String notes,
    required LiveWorkoutModel workout,
  }) {
    try {
      final now = DateTime.now();

      final workoutToAdd = HistoricWorkoutEntity(
        title: title,
        subtitle: workout.subtitle,
        notes: notes,
        startTimestamp: workout.startTimestamp,
        endTimestamp: now,
        updatedAt: now,
        createdAt: now,
      )
        ..primaryMuscleGroups.addAll(workout.primaryMuscleGroups.toEntity())
        ..secondaryMuscleGroups.addAll(workout.secondaryMuscleGroups.toEntity())
        ..sections.addAll(workout.sections.map((e) => e.toEntity()));

      final id = box.put(workoutToAdd);
      final res = box.get(id);

      if (res == null) {
        return left(
          const Failure.internalServerError(
            message: 'Unable to fetch new exercise',
          ),
        );
      }

      return right(res.toModel());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }
}
