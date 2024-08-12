import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manage token in device storage
class IsFirstLoadStore {
  IsFirstLoadStore(this._prefs);

  final SharedPreferences _prefs;

  static const _key = 'is_first_load';

  /// get the token from the device storage
  Either<Failure, bool> get() {
    final v = _prefs.getBool(_key);
    if (v == null) {
      return right(true);
    }

    return right(v);
  }

  /// Store token in device storage
  Future<bool> store({required bool isFirstLoad}) async {
    return _prefs.setBool(
      _key,
      isFirstLoad,
    );
  }
}
