import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/live_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:fpdart/fpdart.dart';

class TrackedWorkoutRepository {
  TrackedWorkoutRepository({required this.store});

  final Store store;

  Box<TrackedWorkout> get box => store.box<TrackedWorkout>();

  Either<Failure, List<TrackedWorkoutModel>> getTrackedWorkouts() {
    try {
      final res = box.getAll().map((e) => e.toModel()).toList();

      return right(res);
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }

  Either<Failure, TrackedWorkoutModel> createTrackedWorkout({
    required String title,
    required LiveWorkoutModel workout,
    String? notes,
  }) {
    try {
      final now = DateTime.now();

      final totalMinutes = now.difference(workout.startTimestamp).inMinutes;

      final workoutToAdd = TrackedWorkout(
        title: title,
        subtitle: workout.subtitle,
        notes: notes,
        durationInMinutes: totalMinutes,
        startTimestamp: workout.startTimestamp,
        updatedAt: now,
        createdAt: now,
      )..sections.addAll(workout.sections.map((e) => e.toEntity()).toList());

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
