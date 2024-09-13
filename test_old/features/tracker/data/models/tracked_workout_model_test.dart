import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'store.dart';

void main() {
  group('TrackedWorkoutModel', () {
    test('ConvertTrackedWorkout', () {
      final model = generateTrackedWorkout();
      final res = model.toEntity();

      expect(res.title, model.title);
      expect(res.subtitle, model.subtitle);
      expect(res.durationInMinutes, model.durationInMinutes);
      expect(res.startTimestamp, model.startTimestamp);
      expect(res.notes, model.notes);
      expect(res.id, model.id);
      expect(res.updatedAt, model.updatedAt);
      expect(res.createdAt, model.createdAt);
    });
  });
}
