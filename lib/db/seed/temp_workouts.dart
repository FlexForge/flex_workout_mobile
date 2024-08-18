import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';

List<TrackedWorkout> generateTrackedWorkouts(int amount) {
  final trackedWorkouts = <TrackedWorkout>[];

  for (var i = 0; i < amount; i++) {
    trackedWorkouts.add(
      TrackedWorkout(
        title: faker.lorem
            .words(faker.randomGenerator.integer(5, min: 1))
            .join(' '),
        subtitle: faker.lorem
            .words(faker.randomGenerator.integer(3, min: 1))
            .join(' '),
        notes: faker.lorem.sentences(5).join(' '),
        durationInMinutes: faker.randomGenerator.integer(180, min: 20),
        startTimestamp:
            faker.date.dateTimeBetween(DateTime(2023), DateTime(2025)),
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
    );
  }

  return trackedWorkouts;
}
