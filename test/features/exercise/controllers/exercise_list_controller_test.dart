import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils.dart';
import '../_stores/exercise_store.dart';

void main() {
  late MockExerciseRepository mockExerciseRepository;

  setUp(() {
    mockExerciseRepository = MockExerciseRepository();
  });

  ProviderContainer createExerciseContainer() {
    return createContainer(
      overrides: [
        exerciseRepositoryProvider.overrideWithValue(mockExerciseRepository),
      ],
    );
  }

  group('ExerciseListController', () {
    group('build', () {
      test('should return list of exercises on call', () {
        final expected = ExerciseModelGenerator.list(length: 10);

        when(
          () => mockExerciseRepository.getExercises(),
        ).thenReturn(right(expected));

        final container = createExerciseContainer();
        final res = container.read(exerciseListControllerProvider);

        expect(res, expected);
      });
    });
  });
}
