import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_view_controller.dart';
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

  group(
    'ExerciseViewController',
    () {
      group('build', () {
        test('should return exercise when id is valid', () {
          final exercise = ExerciseModelGenerator.single();

          when(
            () => mockExerciseRepository.getExerciseById(exercise.id),
          ).thenReturn(right(exercise));

          final ref = createExerciseContainer();
          final res =
              ref.read(exerciseViewControllerProvider(exercise.id.toString()));

          expect(res, exercise);
        });

        test('should throw badRequest when id is invalid', () {
          const id = 'invalid';

          final ref = createExerciseContainer();

          try {
            ref.read(exerciseViewControllerProvider(id));
          } catch (e) {
            expect(e.toString(), 'Failure.badRequest()');
          }
        });

        test('should throw badRequest when id is invalid', () {
          const id = 1;

          when(
            () => mockExerciseRepository.getExerciseById(id),
          ).thenReturn(
            left(
              const Failure.unprocessableEntity(
                message: 'Exercise does not exist',
              ),
            ),
          );

          final container = createExerciseContainer();

          try {
            container.read(exerciseViewControllerProvider(id.toString()));
          } catch (e) {
            expect(
              e.toString(),
              'Failure.unprocessableEntity(message: Exercise does not exist)',
            );
          }
        });
      });
    },
  );
}
