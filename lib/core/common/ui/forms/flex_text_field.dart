import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FlexTextField<T> extends ConsumerWidget {
  const FlexTextField({
    this.formControlName,
    this.formControl,
    this.label,
    this.validationMessages,
    this.hintText,
    this.errorText,
    this.suffix,
    this.showErrors,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.inputCapitalization = TextCapitalization.none,
    this.maxCharacters,
    this.obscureText = false,
    this.isRequired = false,
    this.isTextArea = false,
    this.minLines = 5,
    this.autoFocus = false,
    this.enableBorder = true,
    this.padding = EdgeInsets.zero,
    this.contentPadding,
    this.style,
    this.hintStyle,
    super.key,
  });

  // Reactive Properties
  final String? label;
  final String? formControlName;
  final FormControl<T>? formControl;
  final bool Function(FormControl<T>)? showErrors;
  final bool isRequired;
  final bool obscureText;
  final bool isTextArea;
  final int minLines;
  final bool autoFocus;
  final String? hintText;
  final String? errorText;
  final int? maxCharacters;
  final Widget? suffix;

  final EdgeInsets padding;

  final Map<String, String Function(Object)>? validationMessages;

  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextCapitalization inputCapitalization;

  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool enableBorder;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (label != null)
            Row(
              children: [
                Text(
                  label!,
                  style: context.typography.labelMedium,
                ),
                const Spacer(),
                if (isRequired)
                  Text(
                    'Required',
                    style: context.typography.labelSmall.copyWith(
                      color: context.colors.foregroundSecondary,
                    ),
                  ),
              ],
            ),
          const SizedBox(height: AppLayout.p1),
          ReactiveTextField<T>(
            formControlName: formControlName,
            formControl: formControl,
            showErrors: showErrors,
            textInputAction: inputAction,
            textCapitalization: inputCapitalization,
            textAlignVertical: TextAlignVertical.center,
            obscureText: obscureText,
            autofocus: autoFocus,
            autocorrect: false,
            maxLines: isTextArea ? null : 1,
            minLines: isTextArea ? minLines : 1,
            maxLength: maxCharacters,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            validationMessages: validationMessages,
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
              hintStyle: style?.copyWith(
                    color: context.colors.foregroundSecondary,
                  ) ??
                  context.typography.bodyMedium.copyWith(
                    color: context.colors.foregroundSecondary,
                  ),
              suffix: suffix,
              counterStyle: context.typography.labelXSmall
                  .copyWith(color: context.colors.foregroundSecondary),
              hintMaxLines: isTextArea ? 5 : 1,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: AppLayout.p2,
                    vertical: AppLayout.p3,
                  ),
              focusedBorder: enableBorder
                  ? OutlineInputBorder(
                      // Border style when the field is focused
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: context.colors.foregroundPrimary,
                        width: 2,
                      ),
                    )
                  : const OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: enableBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: context.colors.divider,
                      ),
                      borderRadius:
                          BorderRadius.circular(AppLayout.cornerRadius / 2),
                    )
                  : const OutlineInputBorder(borderSide: BorderSide.none),
              focusedErrorBorder: enableBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.colorScheme.error,
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(AppLayout.cornerRadius / 2),
                    )
                  : const OutlineInputBorder(borderSide: BorderSide.none),
              errorBorder: enableBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.colorScheme.error,
                      ),
                      borderRadius:
                          BorderRadius.circular(AppLayout.cornerRadius / 2),
                    )
                  : const OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
