import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExerciseEntity', () {
    test('ConvertExercise', () {
      final entity = Exercise(
        name: faker.person.name(),
        createdAt: faker.date.dateTime(),
        updatedAt: faker.date.dateTime(),
        description: faker.randomGenerator.string(1500),
        videoUrl: faker.internet.httpsUrl(),
      );
      final res = entity.toModel();

      expect(res.name, entity.name);
      expect(res.createdAt, entity.createdAt);
      expect(res.updatedAt, entity.updatedAt);
      expect(res.description, entity.description);
      expect(res.videoUrl, entity.videoUrl);
      expect(res.id, entity.id);
    });
  });
}
