import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlexButton extends StatelessWidget {
  const FlexButton({
    this.label,
    this.icon,
    this.child,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.padding,
    this.borderRadius,
    this.labelStyle,
    this.iconSize = 20,
    this.borderWidth = 2,
    this.enabled = true,
    this.expanded = false,
    super.key,
  });

  final String? label;
  final TextStyle? labelStyle;
  final IconData? icon;
  final double iconSize;
  final Widget? child;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double borderWidth;
  final bool enabled;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled && onPressed != null
          ? () {
              HapticFeedback.selectionClick();
              onPressed?.call();
            }
          : null,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: NoSplash.splashFactory,
        foregroundColor: foregroundColor ?? context.colors.foregroundPrimary,
        backgroundColor: backgroundColor ?? context.colors.backgroundPrimary,
        disabledForegroundColor:
            disabledForegroundColor ?? context.colors.foregroundTertiary,
        disabledBackgroundColor:
            disabledBackgroundColor ?? context.colors.foregroundQuaternary,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(borderRadius ?? AppLayout.cornerRadius),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth,
          ),
        ),
      ),
      child: Padding(
        padding: padding ??
            EdgeInsets.fromLTRB(
              label == null ? AppLayout.p3 : AppLayout.p4,
              AppLayout.p3,
              label == null
                  ? AppLayout.p3
                  : (icon == null ? AppLayout.p4 : AppLayout.p2),
              AppLayout.p3,
            ),
        child: child ??
            Row(
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (label != null)
                  Text(
                    label!,
                    style: labelStyle ??
                        context.typography.labelLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                if (icon != null && label != null)
                  const SizedBox(width: AppLayout.p1),
                if (icon != null)
                  Icon(
                    icon,
                    size: iconSize,
                  ),
              ],
            ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  const SquareButton({
    required this.label,
    required this.icon,
    this.iconSize = 20,
    this.onPressed,
    super.key,
  });

  final void Function()? onPressed;
  final String label;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlexButton(
          icon: icon,
          iconSize: iconSize,
          padding: const EdgeInsets.all(AppLayout.p2),
          backgroundColor: context.colors.backgroundTertiary,
          foregroundColor: context.colors.foregroundPrimary,
          onPressed: onPressed,
        ),
        const SizedBox(height: AppLayout.p1),
        Text(
          label,
          style: context.typography.labelSmall.copyWith(
            color: context.colors.foregroundPrimary,
          ),
        ),
      ],
    );
  }
}
