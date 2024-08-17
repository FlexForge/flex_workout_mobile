import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:fpdart/fpdart.dart';

class TrackedWorkoutRepository {
  TrackedWorkoutRepository({required this.store});

  final Store store;

  Box<TrackedWorkout> get box => store.box<TrackedWorkout>();

  Either<Failure, TrackedWorkoutModel> createTrackedWorkout({
    required String title,
    required String subtitle,
    required String notes,
    required int durationInMinutes,
    required DateTime startTimestamp,
  }) {
    try {
      final workoutToAdd = TrackedWorkout(
        title: title,
        subtitle: subtitle,
        notes: notes,
        durationInMinutes: durationInMinutes,
        startTimestamp: startTimestamp,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      );
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
