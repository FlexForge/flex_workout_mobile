import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/common/ui/components/segment_controller.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeightUnitDisplay extends ConsumerStatefulWidget {
  const WeightUnitDisplay(
      {required this.selectedValue, required this.onValueChanged, super.key});

  final int selectedValue;

  final void Function(int) onValueChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WeightUnitDisplayState();
}

class _WeightUnitDisplayState extends ConsumerState<WeightUnitDisplay> {
  int _selectedValue = 0;

  @override
  void initState() {
    _selectedValue = widget.selectedValue;
    super.initState();
  }

  void _onSegmentedControllerValueChanged(int value) {
    widget.onValueChanged(value);

    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      header: 'Weight Unit Preset',
      backgroundColor: context.colors.backgroundPrimary,
      body: SegmentedController(
        selectedValue: _selectedValue,
        onValueChanged: _onSegmentedControllerValueChanged,
        items: const ['kg', 'lb'],
        height: 50,
        stretch: true,
      ),
    );
  }
}
