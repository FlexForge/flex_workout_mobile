import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/tracker/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';
import '../../utils.dart';

void main() async {
  ProviderContainer createTrackedWorkoutRepositoryProvider(Store store) {
    return createContainer(
      overrides: [
        objectBoxStoreProvider.overrideWith((ref) {
          return store;
        }),
      ],
    );
  }

  group('trackedWorkoutRepositoryProvider', () {
    test('should return TrackedWorkoutRepository', () async {
      final store = MockObjectBoxStore();
      final container = createTrackedWorkoutRepositoryProvider(store);
      final res = container.read(trackedWorkoutRepositoryProvider);

      expect(res.store, store);
    });
  });
}
