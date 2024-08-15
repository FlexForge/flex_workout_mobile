import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks.dart';
import '../../utils.dart';

void main() async {
  ProviderContainer createUserRepositoryProvider(Store store) {
    return createContainer(
      overrides: [
        objectBoxStoreProvider.overrideWith((ref) {
          return store;
        }),
      ],
    );
  }

  ProviderContainer createOnboardingRepositoryProvider(SharedPreferences pref) {
    return createContainer(
      overrides: [
        sharedPreferencesProvider.overrideWith((ref) {
          return pref;
        }),
      ],
    );
  }

  group('onboardingRepositoryProvider', () {
    test('should throw error when prefs is null', () async {
      SharedPreferences.setMockInitialValues({});
      final pref = await SharedPreferences.getInstance();
      final container = createOnboardingRepositoryProvider(pref);

      try {
        container.read(onboardingRepositoryProvider);
      } catch (e) {
        expect(e.toString(),
            'Failure.internalServerError(message: Shared preferences not initialized)',);
      }
    });

    test('should return IsFirstLoadStore when prefs is NOT null', () async {
      SharedPreferences.setMockInitialValues({
        'is_first_load': true,
      });
      final pref = await SharedPreferences.getInstance();

      final container = createOnboardingRepositoryProvider(pref);
      final res = container.read(onboardingRepositoryProvider);

      // ignore: inference_failure_on_function_invocation
      expect(res.getIsFirstLoad(), right(true));
    });
  });

  group('userRepositoryProvider', () {
    test('should return UserRepository', () async {
      final store = MockObjectBoxStore();
      final container = createUserRepositoryProvider(store);
      final res = container.read(userRepositoryProvider);

      expect(res.store, store);
    });
  });
}
