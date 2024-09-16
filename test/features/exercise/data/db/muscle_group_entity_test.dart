import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_stores/muscle_group_store.dart';

void main() {
  group('MuscleGroupEntity', () {
    test('toModel', () {
      final entity = MuscleGroupEntityGenerator.single();
      final res = entity.toModel();

      expect(res.id, entity.id);
      expect(res.name, entity.name);
      expect(res.diagramPathNames, entity.diagramPathNames);
      expect(res.createdAt, entity.createdAt);
      expect(res.updatedAt, entity.updatedAt);
    });
  });
}
