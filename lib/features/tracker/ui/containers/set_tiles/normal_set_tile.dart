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
    return setType?.normalSet == null
        ? _Incomplete(prefix: prefix, setType: setType)
        : _Completed(prefix: prefix, setType: setType);
  }
}

class _Completed extends StatelessWidget {
  const _Completed({required this.prefix, this.setType});

  final String prefix;
  final CurrentWorkoutSetType? setType;

  @override
  Widget build(BuildContext context) {
    return FlexListTile(
      onTap: () => context.pushNamed(NormalSetScreen.routeName, extra: setType),
      prefix: Center(
        child: Text(
          prefix,
          style: context.typography.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.foregroundTertiary,
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            '${setType?.normalSet?.load} ${setType?.normalSet?.units.name}',
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundTertiary,
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
            '${setType?.normalSet?.reps} reps',
            style: context.typography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.foregroundTertiary,
            ),
          ),
        ],
      ),
      subtitle: Text(
        'Normal Set',
        style: context.typography.bodySmall.copyWith(
          fontWeight: FontWeight.w500,
          color: context.colors.foregroundQuaternary,
        ),
      ),
      suffixPadding: const EdgeInsets.only(right: AppLayout.p4),
      suffix: LargeButton(
        label: 'Complete',
        icon: Symbols.done_all,
        iconSize: 16,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.p4,
          vertical: AppLayout.p1,
        ),
        disabledForegroundColor: context.colors.foregroundTertiary,
        disabledBackgroundColor: context.colors.backgroundTertiary,
      ),
    );
  }
}

class _Incomplete extends StatelessWidget {
  const _Incomplete({required this.prefix, this.setType});

  final String prefix;
  final CurrentWorkoutSetType? setType;

  @override
  Widget build(BuildContext context) {
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
          text: '--',
          style: context.typography.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' lbs',
              style: context.typography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: context.colors.foregroundSecondary,
              ),
            ),
            TextSpan(
              text: ' x --',
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
        setType?.exercise.name ?? 'Exercise',
        overflow: TextOverflow.ellipsis,
        style: context.typography.bodySmall.copyWith(
          fontWeight: FontWeight.w500,
          color: context.colors.foregroundTertiary,
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
