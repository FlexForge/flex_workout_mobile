import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/num_extensions.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class HistoricWorkoutDefaultSetTile extends StatelessWidget {
  const HistoricWorkoutDefaultSetTile({
    required this.set,
    required this.index,
    this.setString = '',
    super.key,
  });

  final int index;
  final String setString;
  final HistoricDefaultSetModel set;

  @override
  Widget build(BuildContext context) {
    return FlexListTile(
      prefix: Center(
        child: Text(
          '${index + 1}$setString',
          style: context.typography.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.foregroundPrimary,
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            set.load.cleanNumber(),
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundPrimary,
            ),
          ),
          Text(
            ' lbs',
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundSecondary,
            ),
          ),
          const SizedBox(width: AppLayout.p1),
          Icon(
            Symbols.close,
            size: 12,
            weight: 900,
            color: context.colors.foregroundTertiary,
          ),
          const SizedBox(width: AppLayout.p1),
          Text(
            set.reps.cleanNumber(),
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundPrimary,
            ),
          ),
          Text(
            ' reps',
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundSecondary,
            ),
          ),
        ],
      ),
      subtitle: Text(
        'Specific set notes',
        style: context.typography.bodySmall.copyWith(
          fontWeight: FontWeight.w500,
          color: context.colors.foregroundTertiary,
        ),
      ),
      suffixPadding: const EdgeInsets.only(right: AppLayout.p4),
      suffix: FlexButton(
        label: 'Complete',
        icon: Symbols.done_all,
        iconSize: 16,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.p4,
          vertical: AppLayout.p1,
        ),
        disabledForegroundColor: context.colors.foregroundSecondary,
        disabledBackgroundColor: context.colors.backgroundTertiary,
      ),
    );
  }
}
