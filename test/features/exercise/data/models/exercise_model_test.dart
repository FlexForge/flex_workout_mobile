import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_stores/exercise_store.dart';

void main() {
  group('ExerciseModel', () {
    test('toEntity', () {
      final model = ExerciseModelGenerator.single();
      final res = model.toEntity();

      expect(res.id, model.id);
      expect(res.name, model.name);
      expect(res.description, model.description);
      expect(res.videoUrl, model.videoUrl);
      expect(res.equipment, model.equipment);
      expect(res.movementPattern, model.movementPattern);
      expect(res.engagement, model.engagement);
      expect(res.createdAt, model.createdAt);
      expect(res.updatedAt, model.updatedAt);
      expect(
        res.primaryMuscleGroups.length,
        model.primaryMuscleGroups.length,
      );
      expect(
        res.secondaryMuscleGroups.length,
        model.secondaryMuscleGroups.length,
      );
    });
  });
}
