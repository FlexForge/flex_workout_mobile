import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExerciseModel', () {
    test('ConvertExercise', () {
      final model = ExerciseModel(
        id: faker.randomGenerator.integer(9999),
        name: faker.person.name(),
        createdAt: faker.date.dateTime(),
        updatedAt: faker.date.dateTime(),
        description: faker.randomGenerator.string(1500),
        videoUrl: faker.internet.httpsUrl(),
        equipment: Equipment.barbell,
        movementPattern: MovementPattern.fly,
      );
      final res = model.toEntity();

      expect(res.name, model.name);
      expect(res.createdAt, model.createdAt);
      expect(res.updatedAt, model.updatedAt);
      expect(res.description, model.description);
      expect(res.videoUrl, model.videoUrl);
      expect(res.id, model.id);
    });
  });
}
