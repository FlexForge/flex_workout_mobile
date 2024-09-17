import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_stores/tracked_workout_store.dart';

void main() {
  group('TrackedWorkoutModel', () {
    group('toEntity', () {
      test('should return a TrackedWorkoutEntity', () {
        final model = TrackedWorkoutModelGenerator.single();
        final res = model.toEntity();

        expect(res.title, model.title);
        expect(res.subtitle, model.subtitle);
        expect(res.notes, model.notes);
        expect(res.durationInMinutes, model.durationInMinutes);
        expect(res.startTimestamp, model.startTimestamp);
        expect(res.updatedAt, model.updatedAt);
        expect(res.createdAt, model.createdAt);
        expect(res.sections.length, model.sections.length);
      });
    });
  });

  group('WorkoutSectionModel', () {
    group('toEntity', () {
      test('should return a WorkoutSectionEntity', () {
        final model = WorkoutSectionModelGenerator.single();
        final res = model.toEntity();

        expect(res.title, model.title);
        expect(res.organizers.length, model.organizers.length);
      });
    });
  });

  group('SetOrganizerModel', () {
    group('toEntity', () {
      test('should return a SetOrganizerEntity', () {
        final model = SetOrganizerModelGenerator.single();
        final res = model.toEntity();

        expect(res.setNumber, model.setNumber);
      });
    });
  });

  group('SetTypeModel', () {
    group('toEntity', () {
      test('should return a SetTypeEntity', () {
        final model = SetTypeModelGenerator.single();
        final res = model.toEntity();

        expect(res.setLetter, model.setLetter);
      });
    });
  });

  group('NormalSetModel', () {
    group('toEntity', () {
      test('should return a NormalSetEntity', () {
        final model = NormalSetModelGenerator.single();
        final res = model.toEntity();

        expect(res.reps, model.reps);
        expect(res.load, model.load);
        expect(res.units, model.units);
      });
    });
  });
}
