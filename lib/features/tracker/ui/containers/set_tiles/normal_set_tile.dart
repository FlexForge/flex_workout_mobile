import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/current_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/normal_set_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class NormalSetTile extends ConsumerWidget {
  const NormalSetTile({required this.prefix, this.setType, super.key});

  final String prefix;
  final CurrentWorkoutSetType? setType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlexListTile(
      onTap: () => context.pushNamed(NormalSetScreen.routeName, extra: setType),
      prefix: Center(
        child: Text(
          prefix,
          style: context.typography.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: setType?.normalSet?.load.toString() ?? '--',
          style: context.typography.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' ${setType?.normalSet?.units.name}',
              style: context.typography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colors.foregroundSecondary,
              ),
            ),
            TextSpan(
              text: ' x ',
              style: context.typography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: setType?.normalSet?.reps.toString() ?? '--',
              style: context.typography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: ' reps',
              style: context.typography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colors.foregroundSecondary,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(
        'Normal Set',
        style: context.typography.bodySmall.copyWith(
          fontWeight: FontWeight.w500,
          color: context.colors.foregroundSecondary,
        ),
      ),
      suffixPadding: const EdgeInsets.only(right: AppLayout.p4),
      suffix: LargeButton(
        label: 'Log set',
        icon: Symbols.edit,
        iconSize: 16,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.p4,
          vertical: AppLayout.p1,
        ),
        disabledForegroundColor: context.colors.foregroundPrimary,
        disabledBackgroundColor: context.colors.backgroundTertiary,
      ),
    );
  }
}
