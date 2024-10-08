import 'package:flex_workout_mobile/features/system/controllers/weight_unit_controller.dart';
import 'package:flex_workout_mobile/features/system/ui/components/weight_unit_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeightUnitSelector extends ConsumerWidget {
  const WeightUnitSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(weightUnitControllerProvider);

    return WeightUnitDisplay(
      selectedValue: unit.index,
      onValueChanged: (value) => ref
          .read(weightUnitControllerProvider.notifier)
          .handle(WeightUnit.values[value]),
    );
  }
}
