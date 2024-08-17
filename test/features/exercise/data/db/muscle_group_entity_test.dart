import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MuscleGroupEntity', () {
    test('ConvertMuscleGroup', () {
      final entity = MuscleGroup(
        name: faker.person.name(),
        diagramPathNames:
            faker.randomGenerator.amount((_) => random.string(10), 8),
        createdAt: faker.date.dateTime(),
        updatedAt: faker.date.dateTime(),
      );
      final res = entity.toModel();

      expect(res.name, entity.name);
      expect(res.createdAt, entity.createdAt);
      expect(res.updatedAt, entity.updatedAt);
      expect(res.diagramPathNames, entity.diagramPathNames);
      expect(res.id, entity.id);
    });
  });
}
