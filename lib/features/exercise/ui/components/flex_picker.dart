import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class FlexPicker<T> extends StatelessWidget {
  const FlexPicker({
    this.display,
    this.displayValue,
    this.modalRouteName,
    this.formControlName,
    this.formControl,
    this.label,
    this.isRequired = false,
    this.padding = EdgeInsets.zero,
    this.hintText = 'Select an option...',
    this.showErrors,
    super.key,
  });

  final String? label;
  final String? formControlName;
  final FormControl<T>? formControl;
  final bool Function(FormControl<T>)? showErrors;
  final String hintText;

  final Widget Function(T)? display;
  final String Function(T)? displayValue;
  final String? modalRouteName;

  final bool isRequired;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<T, T>(
      formControlName: formControlName,
      formControl: formControl,
      showErrors: showErrors,
      builder: (field) {
        return IgnorePointer(
          ignoring: !field.control.enabled,
          child: Listener(
            onPointerDown: (_) => field.control.markAsTouched(),
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (label != null) ...[
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
                  ],
                  if (display != null)
                    display!(field.value as T)
                  else
                    FlexButton(
                      onPressed: () async {
                        final res =
                            await context.pushNamed(modalRouteName!) as T?;

                        if (res == null) return;
                        if (field.value == res) return field.didChange(null);

                        field.didChange(res);
                      },
                      padding: EdgeInsets.zero,
                      foregroundColor: field.context.colors.foregroundPrimary,
                      backgroundColor: field.errorText != null
                          ? field.context.colors.red.withOpacity(0.3)
                          : field.context.colors.backgroundTertiary,
                      disabledForegroundColor:
                          field.context.colors.foregroundSecondary,
                      borderColor: field.errorText != null
                          ? field.context.colors.red
                          : field.context.colors.divider,
                      borderRadius: AppLayout.cornerRadius / 2,
                      borderWidth: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppLayout.p2,
                          vertical: AppLayout.p3,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              field.value != null
                                  ? displayValue!(field.value as T)
                                  : hintText,
                              style:
                                  field.context.typography.bodyMedium.copyWith(
                                color: field.errorText != null
                                    ? field.context.colors.red
                                    : (field.value != null
                                        ? field.context.colors.foregroundPrimary
                                        : field.context.colors
                                            .foregroundSecondary),
                                fontWeight: field.value != null
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: field.errorText != null
                                  ? field.context.colors.red
                                  : field.context.colors.foregroundPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
