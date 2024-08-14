import 'package:flex_workout_mobile/features/auth/data/db/is_first_load_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('IsFirstLoadStore', () {
    group('get', () {
      test('should return true when isFirstLoad is null', () async {
        SharedPreferences.setMockInitialValues({});
        final pref = await SharedPreferences.getInstance();
        final store = IsFirstLoadStore(pref);

        final res = store.get().getOrElse((_) => false);

        expect(res, true);
      });

      test('should return true when isFirstLoad is true', () async {
        SharedPreferences.setMockInitialValues({
          'is_first_load': true,
        });
        final pref = await SharedPreferences.getInstance();
        final store = IsFirstLoadStore(pref);

        final res = store.get().getOrElse((_) => false);

        expect(res, true);
      });

      test('should return false when isFirstLoad is false', () async {
        SharedPreferences.setMockInitialValues({
          'is_first_load': false,
        });
        final pref = await SharedPreferences.getInstance();
        final store = IsFirstLoadStore(pref);

        final res = store.get().getOrElse((_) => true);

        expect(res, false);
      });
    });

    group('store', () {
      test('should return true when isFirstLoad is true', () async {
        SharedPreferences.setMockInitialValues({});
        final pref = await SharedPreferences.getInstance();
        final store = IsFirstLoadStore(pref);

        final res = await store.store(isFirstLoad: true);
        final value = store.get().getOrElse((_) => false);

        expect(res, true);
        expect(value, true);
      });

      test('should return true when isFirstLoad is false', () async {
        SharedPreferences.setMockInitialValues({});
        final pref = await SharedPreferences.getInstance();
        final store = IsFirstLoadStore(pref);

        final res = await store.store(isFirstLoad: false);
        final value = store.get().getOrElse((_) => true);

        expect(res, true);
        expect(value, false);
      });
    });
  });
}
