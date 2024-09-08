import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class NormalSetTile extends StatelessWidget {
  const NormalSetTile({required this.prefix, super.key});

  final String prefix;

  @override
  Widget build(BuildContext context) {
    return FlexListTile(
      onTap: () {},
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
        'Normal Set',
        style: context.typography.bodySmall.copyWith(
          fontWeight: FontWeight.w500,
          color: context.colors.foregroundSecondary,
        ),
      ),
      suffixPadding: const EdgeInsets.only(right: AppLayout.p4),
      suffix: LargeButton(
        onPressed: () {},
        label: 'Log set',
        icon: Symbols.edit,
        iconSize: 16,
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.p4,
          vertical: AppLayout.p1,
        ),
        backgroundColor: context.colors.backgroundTertiary,
      ),
    );
  }
}
