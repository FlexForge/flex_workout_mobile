import 'package:flutter_test/flutter_test.dart';

import '../../_stores/historic_workout_store.dart';

void main() {
  group('HistoricWorkoutModel', () {
    test('toEntity', () {
      final model = HistoricWorkoutModelGenerator.single();
      final res = model.toEntity();

      expect(res.id, model.id);
    });
  });
}
