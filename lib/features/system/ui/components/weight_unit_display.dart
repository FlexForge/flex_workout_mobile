import 'package:flex_workout_mobile/core/common/ui/components/flex_radio_list_item.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class WeightUnitDisplay extends ConsumerStatefulWidget {
  const WeightUnitDisplay({
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

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

  void _onValueChanged(int value) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioListItem(
            name: Units.kgs.fullName,
            icon: Symbols.circle,
            value: Units.kgs,
            onPressed: () => _onValueChanged(Units.kgs.index),
            selected: Units.kgs.index == _selectedValue,
          ),
          const SizedBox(height: AppLayout.p2),
          RadioListItem(
            name: Units.lbs.fullName,
            icon: Symbols.circle,
            value: Units.lbs,
            onPressed: () => _onValueChanged(Units.lbs.index),
            selected: Units.lbs.index == _selectedValue,
          ),
        ],
      ),
    );
  }
}
