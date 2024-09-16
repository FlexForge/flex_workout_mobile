import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_stores/exercise_store.dart';

void main() {
  group('ExerciseEntity', () {
    test('toModel', () {
      final entity = ExerciseEntityGenerator.single();
      final res = entity.toModel();

      expect(res.id, entity.id);
      expect(res.name, entity.name);
      expect(res.description, entity.description);
      expect(res.videoUrl, entity.videoUrl);
      expect(res.equipment, entity.equipment);
      expect(res.movementPattern, entity.movementPattern);
      expect(res.engagement, entity.engagement);
      expect(res.createdAt, entity.createdAt);
      expect(res.updatedAt, entity.updatedAt);
      expect(
        res.primaryMuscleGroups.length,
        entity.primaryMuscleGroups.length,
      );
      expect(
        res.secondaryMuscleGroups.length,
        entity.secondaryMuscleGroups.length,
      );
    });
  });
}
