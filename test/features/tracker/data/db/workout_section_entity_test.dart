import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/workout_section_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../exercise/data/db/store.dart';

void main() {
  group('WorkoutSection', () {
    test('ConvertWorkoutSection', () {
      final entity = WorkoutSection(title: faker.lorem.sentence());
      final res = entity.toModel();

      expect(res.title, entity.title);
    });
  });

  group('SetOrganizer', () {
    test('ConvertSetOrganizer', () {
      final entity = SetOrganizer();
      final res = entity.toModel();

      expect(res.id, entity.id);
    });
  });

  group('SetType', () {
    test('ConvertSetType', () {
      final exercise = generateRandomExercise().toEntity();
      final entity = SetType()..exercise.target = exercise;
      final res = entity.toModel();

      expect(res.id, entity.id);
    });
  });

  group('NormalSet', () {
    test('ConvertNormalSet', () {
      final entity = NormalSet();
      final res = entity.toModel();

      expect(res.id, entity.id);
    });
  });
}