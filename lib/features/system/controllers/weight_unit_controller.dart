import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weight_unit_controller.g.dart';

@riverpod
class WeightUnitController extends _$WeightUnitController {
  @override
  Units build() {
    final res = ref.watch(userRepositoryProvider).getUser();

    return res.fold((l) => Units.kgs, (r) => r.preferredWeightUnit);
  }

  void handle(Units unit) {
    final res = ref.read(userRepositoryProvider).updateWeightUnit(unit: unit);

    state = res.fold((l) => throw l, (r) => r);
  }
}
