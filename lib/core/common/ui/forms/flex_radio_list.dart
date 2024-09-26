import 'package:flex_workout_mobile/core/common/ui/components/flex_radio_list_item.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class FlexRadioList<T extends RadioListItemMixin<K>, K>
    extends ReactiveFormField<K, K> {
  FlexRadioList({
    required List<T> options,
    // ignore: avoid_positional_boolean_parameters
    required T Function(T, bool, VoidCallback) builder,
    int columnCount = 1,
    double columnGap = 0,
    double rowGap = 0,
    EdgeInsets padding = EdgeInsets.zero,
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
  }) : super(
          builder: (field) {
            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Listener(
                onPointerDown: (_) => field.control.markAsTouched(),
                child: Padding(
                  padding: padding,
                  child: LayoutGrid(
                    columnGap: columnGap,
                    rowGap: rowGap,
                    columnSizes: List.generate(
                      columnCount,
                      (_) => 1.fr,
                    ),
                    rowSizes: List.generate(
                      (options.length / columnCount).ceil(),
                      (_) => auto,
                    ),
                    children: options
                        .map(
                          (e) => builder(e, field.value == e.value, () {
                            field.didChange(e.value);
                          }),
                        )
                        .toList(),
                  ),
                ),
              ),
            );
          },
        );
}
