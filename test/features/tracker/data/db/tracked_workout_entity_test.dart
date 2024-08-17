import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TrackedWorkout', () {
    test('ConvertEConvertTrackedWorkout', () {
      final entity = TrackedWorkout(
        title: faker.person.name(),
        subtitle: faker.person.name(),
        durationInMinutes: faker.randomGenerator.integer(100),
        startTimestamp: faker.date.dateTime(),
        notes: faker.randomGenerator.string(1500),
        createdAt: faker.date.dateTime(),
        updatedAt: faker.date.dateTime(),
      );
      final res = entity.toModel();

      expect(res.title, entity.title);
      expect(res.subtitle, entity.subtitle);
      expect(res.durationInMinutes, entity.durationInMinutes);
      expect(res.startTimestamp, entity.startTimestamp);
      expect(res.notes, entity.notes);
      expect(res.id, entity.id);
      expect(res.updatedAt, entity.updatedAt);
      expect(res.createdAt, entity.createdAt);
    });
  });
}
