import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_radio_list_item.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_radio_list.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/forms/equipment_picker.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_picker.dart';
import 'package:flex_workout_mobile/features/exercise/ui/forms/movement_pattern_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseCreateFormStepTwo extends ConsumerWidget {
  const ExerciseCreateFormStepTwo({
    required this.next,
    required this.back,
    super.key,
  });

  final VoidCallback next;
  final VoidCallback back;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(exerciseFormControllerProvider).advancedForm;

    return ReactiveAdvancedForm(
      form: form,
      child: FormWrapper(
        backgroundColor: context.colors.backgroundSecondary,
        actionButtons: [
          FlexButton(
            onPressed: back,
            icon: Icons.chevron_left,
            backgroundColor: context.colors.backgroundTertiary,
          ),
          const SizedBox(width: AppLayout.p3),
          ReactiveAdvancedFormConsumer(
            builder: (context, form, child) => Expanded(
              child: FlexButton(
                enabled: form.currentForm.valid,
                onPressed: next,
                label: 'Next',
                icon: Icons.chevron_right,
                backgroundColor: context.colors.foregroundPrimary,
                foregroundColor: context.colors.backgroundPrimary,
              ),
            ),
          ),
        ],
        form: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlexPicker(
              formControl: form.equipmentControl,
              label: 'Equipment',
              displayValue: (e) => e.readableName,
              modalRouteName: EquipmentPicker.routeName,
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
            const SizedBox(height: AppLayout.p4),
            FlexPicker(
              formControl: form.movementPatternControl,
              label: 'Movement Pattern',
              displayValue: (e) => e.readableName,
              modalRouteName: MovementPatternPicker.routeName,
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
            const SizedBox(height: AppLayout.p4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: Text(
                'Engagement',
                style: context.typography.labelMedium,
              ),
            ),
            const SizedBox(height: AppLayout.p2),
            FlexRadioList(
              formControl: form.engagementControl,
              columnGap: AppLayout.p2,
              rowGap: AppLayout.p2,
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              builder: (e, selected, onPressed) => RadioListItem(
                name: e.name,
                icon: e.icon,
                value: e.value,
                description: e.description,
                selected: selected,
                onPressed: onPressed,
                padding: const EdgeInsets.symmetric(vertical: AppLayout.p4),
              ),
              options: Engagement.values
                  .map(
                    (pattern) => RadioListItem(
                      name: pattern.readableName,
                      icon: pattern.icon ?? Symbols.brightness_1,
                      description: pattern.description,
                      value: pattern,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
