import 'package:flex_workout_mobile/core/common/ui/components/segment_controller.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class FlexSegmentedControl extends ReactiveFormField<int, int> {
  FlexSegmentedControl({
    required List<String> options,
    double padding = AppLayout.p4,
    double borderRadius = AppLayout.cornerRadius,
    Color? thumbColor,
    Color? thumbBorderColor,
    Color? backgroundColor,
    Color? foregroundSelectedColor,
    Color? foregroundUnselectedColor,
    TextStyle? textStyle,
    double? height,
    bool stretch = false,
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
                child: SegmentedController(
                  initialValue: field.value,
                  selectedValue: field.value ?? 0,
                  onValueChanged: field.didChange,
                  items: options,
                  stretch: stretch,
                  padding: padding,
                  borderRadius: borderRadius,
                  thumbColor: thumbColor,
                  thumbBorderColor: thumbBorderColor,
                  backgroundColor: backgroundColor,
                  foregroundSelectedColor: foregroundSelectedColor,
                  foregroundUnselectedColor: foregroundUnselectedColor,
                  textStyle: textStyle,
                  height: height,
                ),
              ),
            );
          },
        );
}
