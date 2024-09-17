import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_list_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../exercise/_stores/exercise_store.dart';

void main() {
  late MockExerciseRepository mockExerciseRepository;

  setUp(() {
    mockExerciseRepository = MockExerciseRepository();
  });

  ProviderContainer createExerciseContainer() {
    return ProviderContainer(
      overrides: [
        exerciseRepositoryProvider.overrideWithValue(mockExerciseRepository),
      ],
    );
  }

  group('ExerciseSelectionListController', () {
    group('build', () {
      test('should return list of exercises on call', () {
        final expected = ExerciseModelGenerator.list(length: 10);

        when(
          () => mockExerciseRepository.getExercises(),
        ).thenReturn(right(expected));

        final container = createExerciseContainer();
        final res = container.read(exerciseSelectionListControllerProvider);

        expect(res, expected);
      });
    });
    group('toSelectionMap', () {
      test(
        'should return a map of exercises separated by first letter',
        () {
          final names = ['A name', 'A name', 'C name', 'D name', 'E name'];
          final exercise = names
              .map((name) => ExerciseModelGenerator.single(name: name))
              .toList();

          final expected = {
            'A': [exercise[0], exercise[1]],
            'C': [exercise[2]],
            'D': [exercise[3]],
            'E': [exercise[4]],
          };

          final res = exercise.toSelectionMap();

          expect(res, expected);
        },
      );

      test(
        'should return a map of exercises with # key',
        () {
          final names = ['1 name', '2 name', 'D name', 'E name', '3 name'];
          final exercise = names
              .map((name) => ExerciseModelGenerator.single(name: name))
              .toList();

          final expected = {
            '#': [exercise[0], exercise[1], exercise[4]],
            'D': [exercise[2]],
            'E': [exercise[3]],
          };

          final res = exercise.toSelectionMap();

          expect(res, expected);
        },
      );
    });
  });
}
