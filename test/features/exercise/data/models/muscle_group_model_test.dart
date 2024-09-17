import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_stores/muscle_group_store.dart';

void main() {
  group('MuscleGroupModel', () {
    test('toEntity', () {
      final model = MuscleGroupModelGenerator.single();
      final res = model.toEntity();

      expect(res.id, model.id);
      expect(res.name, model.name);
      expect(res.diagramPathNames, model.diagramPathNames);
      expect(res.createdAt, model.createdAt);
      expect(res.updatedAt, model.updatedAt);
    });
  });
}
