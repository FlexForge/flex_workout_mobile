import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_stores/tracked_workout_store.dart';

void main() {
  group('TrackedWorkout', () {
    test('toModel', () {
      final entity = TrackedWorkoutEntityGenerator.single();
      final res = entity.toModel();

      expect(res.id, entity.id);
      expect(res.title, entity.title);
      expect(res.subtitle, entity.subtitle);
      expect(res.notes, entity.notes);
      expect(res.durationInMinutes, entity.durationInMinutes);
      expect(res.startTimestamp, entity.startTimestamp);
      expect(res.updatedAt, entity.updatedAt);
      expect(res.createdAt, entity.createdAt);
      expect(res.sections.length, entity.sections.length);
    });
  });

  group('WorkoutSection', () {
    group('toModel', () {
      test('should return a WorkoutSectionModel', () {
        final entity = WorkoutSectionEntityGenerator.single();
        final res = entity.toModel();

        expect(res.id, entity.id);
        expect(res.title, entity.title);
        expect(res.organizers.length, entity.organizers.length);
      });
    });
  });

  group('SetOrganizer', () {
    group('toModel', () {
      test('should return a SetOrganizerModel', () {
        final entity = SetOrganizerEntityGenerator.single();
        final res = entity.toModel();

        expect(res.id, entity.id);
        expect(res.setNumber, entity.setNumber);
      });
    });
  });

  group('SetType', () {
    group('toModel', () {
      test('should return a SetTypeModel', () {
        final entity = SetTypeEntityGenerator.single();
        final res = entity.toModel();

        expect(res.id, entity.id);
        expect(res.setLetter, entity.setLetter);
      });
    });
  });

  group('NormalSet', () {
    group('toModel', () {
      test('should return a NormalSetModel', () {
        final entity = NormalSetEntityGenerator.single();
        final res = entity.toModel();

        expect(res.id, entity.id);
        expect(res.reps, entity.reps);
        expect(res.load, entity.load);
        expect(res.units, entity.units);
      });
    });
  });
}
