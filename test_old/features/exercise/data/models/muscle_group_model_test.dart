import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MuscleGroupModel', () {
    test('ConvertMuscleGroup', () {
      final model = MuscleGroupModel(
        id: faker.randomGenerator.integer(9999),
        name: faker.person.name(),
        diagramPathNames:
            faker.randomGenerator.amount((_) => random.string(10), 8),
        createdAt: faker.date.dateTime(),
        updatedAt: faker.date.dateTime(),
      );
      final res = model.toEntity();

      expect(res.name, model.name);
      expect(res.createdAt, model.createdAt);
      expect(res.updatedAt, model.updatedAt);
      expect(res.diagramPathNames, model.diagramPathNames);
      expect(res.id, model.id);
    });
  });
}
