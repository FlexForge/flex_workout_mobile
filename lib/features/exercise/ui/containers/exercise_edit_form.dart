import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_radio_list_item.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_picker.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_radio_list.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_display.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_field.dart';
import 'package:flex_workout_mobile/features/exercise/ui/forms/equipment_picker.dart';
import 'package:flex_workout_mobile/features/exercise/ui/forms/movement_pattern_picker.dart';
import 'package:flex_workout_mobile/features/exercise/ui/forms/primary_muscle_group_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class ExerciseEditForm extends ConsumerStatefulWidget {
  const ExerciseEditForm({required this.exercise, super.key});

  final ExerciseModel exercise;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExerciseEditFormState();
}

class _ExerciseEditFormState extends ConsumerState<ExerciseEditForm> {
  @override
  void initState() {
    ref
        .read(exerciseFormControllerProvider.notifier)
        .autofillForm(widget.exercise);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(exerciseFormControllerProvider);

    return ReactiveExerciseForm(
      form: form,
      child: FormWrapper(
        backgroundColor: context.colors.backgroundSecondary,
        actionButtons: [
          ReactiveExerciseFormConsumer(
            builder: (context, form, child) => Expanded(
              child: FlexButton(
                enabled: form.form.valid,
                onPressed: () => ref
                    .read(exerciseFormControllerProvider.notifier)
                    .update(widget.exercise),
                label: 'Update Exercise',
                icon: Symbols.add_task,
                backgroundColor: context.colors.foregroundPrimary,
                foregroundColor: context.colors.backgroundPrimary,
              ),
            ),
          ),
        ],
        form: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FlexTextField<String>(
              formControl: form.generalForm.nameControl,
              label: 'Name',
              hintText: 'Exercise name',
              isRequired: true,
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'The exercise name is required',
              },
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
            const SizedBox(height: AppLayout.p4),
            FlexTextField<String>(
              formControl: form.generalForm.descriptionControl,
              label: 'Description',
              hintText: 'Describe the exercise, included the setup and the'
                  ' steps required to perform this exercise.',
              isTextArea: true,
              maxCharacters: 1500,
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'The exercise name is required',
              },
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
            const SizedBox(height: AppLayout.p2),
            FlexTextField<String>(
              formControl: form.generalForm.videoUrlControl,
              label: 'Video Clip',
              hintText: 'Enter the url of a demo video',
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
            const SizedBox(height: AppLayout.p8),
            Divider(height: 0, thickness: 1, color: context.colors.divider),
            const SizedBox(height: AppLayout.p8),
            FlexPicker(
              formControl: form.advancedForm.equipmentControl,
              label: 'Equipment',
              displayValue: (e) => e.readableName,
              modalRouteName: EquipmentPicker.routeName,
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
            const SizedBox(height: AppLayout.p4),
            FlexPicker(
              formControl: form.advancedForm.movementPatternControl,
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
              formControl: form.advancedForm.engagementControl,
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
            const SizedBox(height: AppLayout.p8),
            Divider(height: 0, thickness: 1, color: context.colors.divider),
            const SizedBox(height: AppLayout.p8),
            ReactiveExerciseFormConsumer(
              builder: (context, form, child) => Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MuscleGroupDisplay(
                      muscleGroups: frontMuscleGroups,
                      primaryMuscleGroups:
                          form.model.muscleGroups?.primaryMuscleGroups ?? [],
                      secondaryMuscleGroups:
                          form.model.muscleGroups?.secondaryMuscleGroups ?? [],
                    ),
                    const SizedBox(width: AppLayout.p4),
                    MuscleGroupDisplay(
                      muscleGroups: backMuscleGroups,
                      primaryMuscleGroups:
                          form.model.muscleGroups?.primaryMuscleGroups ?? [],
                      secondaryMuscleGroups:
                          form.model.muscleGroups?.secondaryMuscleGroups ?? [],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppLayout.p6),
            MuscleGroupField(
              formControl: form.muscleGroupsForm.primaryMuscleGroupsControl,
              modalRouteName: PrimaryMuscleGroupPicker.routeName,
              label: 'Primary Muscle Groups',
            ),
            const SizedBox(height: AppLayout.p6),
            MuscleGroupField(
              formControl: form.muscleGroupsForm.secondaryMuscleGroupsControl,
              modalRouteName: SecondaryMuscleGroupsPicker.routeName,
              label: 'Secondary Muscle Groups',
            ),
          ],
        ),
      ),
    );
  }
}
