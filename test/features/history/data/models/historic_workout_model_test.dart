import 'package:flex_workout_mobile/features/history/data/db/historic_workout_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_stores/historic_workout_store.dart';

void main() {
  group('HistoricWorkoutModel', () {
    test('should be unaffected by transformations', () {
      final model = HistoricWorkoutModelGenerator.single();
      final entity = model.toEntity();
      final model2 = entity.toModel();
      final entity2 = model2.toEntity();
      final model3 = entity2.toModel();

      expect(model2, model);
      expect(entity2, entity);
    });
  });
}
