import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';
import '../../utils.dart';

void main() {
  ProviderContainer createExerciseRepositoryProvider(Store store) {
    return createContainer(
      overrides: [
        objectBoxStoreProvider.overrideWith((ref) {
          return store;
        }),
      ],
    );
  }

  group('Providers', () {
    group('userRepositoryProvider', () {
      test('should return UserRepository', () async {
        final store = MockObjectBoxStore();
        final container = createExerciseRepositoryProvider(store);
        final res = container.read(exerciseRepositoryProvider);

        expect(res.store, store);
      });
    });
  });
}
