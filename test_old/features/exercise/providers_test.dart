import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';
import '../../utils.dart';

void main() async {
  ProviderContainer createExerciseRepositoryProvider(Store store) {
    return createContainer(
      overrides: [
        objectBoxStoreProvider.overrideWith((ref) {
          return store;
        }),
      ],
    );
  }

  group('exerciseRepositoryProvider', () {
    test('should return ExerciseRepository', () async {
      final store = MockObjectBoxStore();
      final container = createExerciseRepositoryProvider(store);
      final res = container.read(exerciseRepositoryProvider);

      expect(res.store, store);
    });
  });
}
