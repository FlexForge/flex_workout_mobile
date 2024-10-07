import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';

class FlexSearchBar extends StatelessWidget {
  const FlexSearchBar({
    required this.onChanged,
    this.initialValue,
    this.hintText,
    this.suffix,
    this.prefixIcon,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.inputCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.autoFocus = false,
    this.enableBorder = true,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
    this.contentPadding,
    this.style,
    this.hintStyle,
    super.key,
  });

  // Reactive Properties
  final bool obscureText;
  final bool autoFocus;
  final String? hintText;
  final Widget? suffix;
  final IconData? prefixIcon;
  final String? initialValue;

  final EdgeInsets padding;

  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextCapitalization inputCapitalization;

  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool enableBorder;
  final EdgeInsets? contentPadding;
  final Color? backgroundColor;

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          textInputAction: inputAction,
          textCapitalization: inputCapitalization,
          textAlignVertical: TextAlignVertical.center,
          obscureText: obscureText,
          autofocus: autoFocus,
          autocorrect: false,
          style: style ??
              context.typography.bodyMedium.copyWith(
                color: context.colors.foregroundPrimary,
                fontWeight: FontWeight.w500,
              ),
          keyboardType: inputType,
          cursorColor: context.colors.foregroundPrimary,
          decoration: InputDecoration(
            isCollapsed: true,
            hintText: hintText,
            fillColor: backgroundColor ?? context.colors.backgroundSecondary,
            filled: true,
            hintStyle: style?.copyWith(
                  color: context.colors.foregroundSecondary,
                ) ??
                context.typography.bodyMedium.copyWith(
                  color: context.colors.foregroundSecondary,
                ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    size: 20,
                    weight: 700,
                    color: context.colors.foregroundPrimary,
                  )
                : null,
            isDense: true,
            prefixIconConstraints: const BoxConstraints(minWidth: 44),
            counterStyle: context.typography.labelXSmall
                .copyWith(color: context.colors.foregroundSecondary),
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: AppLayout.p2,
                  vertical: AppLayout.p3,
                ),
            focusedBorder: enableBorder
                ? OutlineInputBorder(
                    // Border style when the field is focused
                    borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
                    borderSide: BorderSide(
                      color: context.colors.foregroundPrimary,
                      width: 2,
                    ),
                  )
                : const OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: enableBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          backgroundColor ?? context.colors.backgroundSecondary,
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
                  )
                : const OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
        if (suffix != null)
          Positioned(
            right: 0,
            child: suffix!,
          ),
      ],
    );
  }
}
