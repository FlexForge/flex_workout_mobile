import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
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

  Either<Failure, WorkoutModel> createWorkout({
    required List<IWorkoutSection> sections,
    required String title,
    required String subtitle,
    required List<MuscleGroupModel> primaryMuscleGroups,
    required List<MuscleGroupModel> secondaryMuscleGroups,
    String? description,
  }) {
    try {
      final now = DateTime.now();

      final workoutToAdd = WorkoutEntity(
        title: title,
        subtitle: subtitle,
        description: description ?? '',
        updatedAt: now,
        createdAt: now,
      )
        ..primaryMuscleGroups.addAll(primaryMuscleGroups.toEntity())
        ..secondaryMuscleGroups.addAll(secondaryMuscleGroups.toEntity())
        ..sections.addAll(
          sections.map((e) => e.toEntity()).cast(),
        );

      final id = box.put(
        workoutToAdd,
        mode: PutMode.insert,
      );
      final res = box.get(id);

      if (res == null) {
        return left(
          const Failure.internalServerError(
            message: 'Unable to fetch new workout',
          ),
        );
      }

      return right(res.toModel());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }
}
