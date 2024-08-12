import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/auth/data/db/is_first_load_store.dart';
import 'package:fpdart/fpdart.dart';

class OnboardingRepository {
  OnboardingRepository(this.isFirstLoadStore);

  final IsFirstLoadStore isFirstLoadStore;

  Either<Failure, bool> getIsFirstLoad() {
    try {
      final res = isFirstLoadStore.get();
      if (res.isLeft()) {
        return left(const Failure.empty());
      }

      return right(res.getOrElse((_) => true));
    } catch (_) {
      return left(const Failure.unauthorized());
    }
  }

  Future<Either<Failure, bool>> setIsFirstLoad({
    required bool isFirstLoad,
  }) async {
    try {
      await isFirstLoadStore.store(isFirstLoad: isFirstLoad);

      return right(true);
    } catch (_) {
      return left(const Failure.badRequest());
    }
  }
}
