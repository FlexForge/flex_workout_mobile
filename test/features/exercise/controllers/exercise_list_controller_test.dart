import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  late MockExerciseRepository mockExerciseRepository;

  setUp(() {
    mockExerciseRepository = MockExerciseRepository();
  });

  ProviderContainer createExerciseListContainer() {
    return createContainer(
      overrides: [
        exerciseRepositoryProvider.overrideWithValue(mockExerciseRepository),
      ],
    );
  }

  group('ExerciseListController', () {
    test('should return list of exercises on call', () {
      final expected = masterExercises.map((e) => e.toModel()).toList();

      when(
        () => mockExerciseRepository.getExercises(),
      ).thenReturn(right(expected));

      final container = createExerciseListContainer();
      final res = container.read(exerciseListControllerProvider);

      expect(res, expected);
    });
  });
}
