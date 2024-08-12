import 'package:flex_workout_mobile/core/common/ui/components/flex_radio_list_item.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class FlexRadioList<T extends RadioListItemMixin>
    extends ReactiveFormField<int, int> {
  FlexRadioList({
    required List<T> options,
    // ignore: avoid_positional_boolean_parameters
    required T Function(T, bool, VoidCallback) builder,
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
                child: Column(
                  children: options
                      .mapWithIndex(
                        (e, index) => Column(
                          children: [
                            builder(e, field.value == index, () {
                              field.didChange(index);
                            }),
                            const SizedBox(height: AppLayout.p2),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          },
        );
}
