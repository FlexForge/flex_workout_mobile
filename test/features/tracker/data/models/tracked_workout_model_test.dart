import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TrackedWorkoutModel', () {
    test('ConvertTrackedWorkout', () {
      final model = TrackedWorkoutModel(
        id: faker.randomGenerator.integer(9999),
        title: faker.person.name(),
        subtitle: faker.person.name(),
        durationInMinutes: faker.randomGenerator.integer(100),
        startTimestamp: faker.date.dateTime(),
        notes: faker.randomGenerator.string(1500),
        createdAt: faker.date.dateTime(),
        updatedAt: faker.date.dateTime(),
      );
      final res = model.toEntity();

      expect(res.title, model.title);
      expect(res.subtitle, model.subtitle);
      expect(res.durationInMinutes, model.durationInMinutes);
      expect(res.startTimestamp, model.startTimestamp);
      expect(res.notes, model.notes);
      expect(res.id, model.id);
      expect(res.updatedAt, model.updatedAt);
      expect(res.createdAt, model.createdAt);
    });
  });
}
