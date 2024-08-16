import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flutter/widgets.dart';

class StackedText extends StatelessWidget {
  const StackedText({
    required this.heading,
    required this.subHeading,
    this.tertiaryHeading,
    this.alignment = CrossAxisAlignment.center,
    this.suffix,
    super.key,
  });

  final String heading;
  final String subHeading;
  final String? tertiaryHeading;

  final CrossAxisAlignment alignment;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: heading,
            style: context.typography.headlineMedium.copyWith(
              color: context.colors.foregroundPrimary,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              if (suffix != null)
                TextSpan(
                  text: ' ${suffix!}',
                  style: context.typography.headlineMedium.copyWith(
                    color: context.colors.foregroundSecondary,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
        Text(
          subHeading,
          style: context.typography.labelMedium.copyWith(
            color: context.colors.foregroundSecondary,
          ),
        ),
        if (tertiaryHeading != null)
          Text(
            tertiaryHeading!,
            style: context.typography.labelMedium.copyWith(
              color: context.colors.foregroundSecondary,
            ),
          ),
      ],
    );
  }
}
