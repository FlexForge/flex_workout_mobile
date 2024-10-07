import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';

mixin RadioListItemMixin<T> on Widget {
  bool get selected;
  T get value;
  VoidCallback? get onPressed;
}

class RadioListItem<T> extends StatelessWidget
    implements RadioListItemMixin<T> {
  const RadioListItem({
    required this.name,
    required this.icon,
    required this.value,
    this.description,
    this.padding = EdgeInsets.zero,
    this.selected = false,
    this.shrinkWrap = false,
    this.onPressed,
    super.key,
  });

  final String name;
  final IconData icon;

  final String? description;

  final EdgeInsets padding;
  final bool shrinkWrap;

  @override
  final T value;
  @override
  final bool selected;
  @override
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FlexButton(
      onPressed: onPressed,
      borderColor:
          selected ? context.colors.foregroundPrimary : context.colors.divider,
      borderWidth: selected ? 2 : 1,
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
          children: [
            Icon(icon),
            const SizedBox(width: AppLayout.p3),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: context.typography.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  if (description != null) ...[
                    const SizedBox(height: AppLayout.p1),
                    Text(
                      description!,
                      style: context.typography.labelMedium
                          .copyWith(color: context.colors.foregroundSecondary),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
