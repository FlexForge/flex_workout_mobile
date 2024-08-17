import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/widgets.dart';

class TextWithColor extends StatelessWidget {
  const TextWithColor({
    required this.label,
    required this.color,
    required this.value,
    this.isLarge = false,
    super.key,
  });

  final bool isLarge;

  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isLarge ? 5 : 8,
          height: isLarge ? 44 : 32,
          color: color,
        ),
        const SizedBox(width: AppLayout.p2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: context.typography.labelLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              label,
              style: context.typography.labelSmall.copyWith(
                color: context.colors.foregroundSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
