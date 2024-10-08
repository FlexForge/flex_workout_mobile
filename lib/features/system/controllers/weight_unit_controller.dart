import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weight_unit_controller.g.dart';

@riverpod
class WeightUnitController extends _$WeightUnitController {
  @override
  WeightUnit build() {
    final res = ref.watch(userRepositoryProvider).getUser();

    return res.fold((l) => WeightUnit.kg, (r) => r.preferredWeightUnit);
  }

  void handle(WeightUnit unit) {
    final res = ref.read(userRepositoryProvider).updateWeightUnit(unit: unit);

    state = res.fold((l) => throw l, (r) => r);
  }
}
