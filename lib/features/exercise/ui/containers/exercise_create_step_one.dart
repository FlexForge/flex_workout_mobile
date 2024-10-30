import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/segment_controller.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_picker.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/forms/base_exercise_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class ExerciseCreateFormStepOne extends ConsumerStatefulWidget {
  const ExerciseCreateFormStepOne({required this.next, super.key});

  final VoidCallback next;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExerciseCreateFormStepOneState();
}

class _ExerciseCreateFormStepOneState
    extends ConsumerState<ExerciseCreateFormStepOne> {
  int _selectedValue = 0;

  void _onSegmentedControllerValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(exerciseFormControllerProvider).generalForm;

    return ReactiveGeneralForm(
      form: form,
      child: FormWrapper(
        backgroundColor: context.colors.backgroundSecondary,
        actionButtons: [
          ReactiveGeneralFormConsumer(
            builder: (context, form, child) => Expanded(
              child: FlexButton(
                enabled: form.currentForm.valid,
                onPressed: widget.next,
                label: 'Next',
                icon: Icons.chevron_right,
                backgroundColor: context.colors.foregroundPrimary,
                foregroundColor: context.colors.backgroundPrimary,
              ),
            ),
          ),
        ],
        form: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: Text(
                'Is this a new exercise or a variation on an existing one?',
                style: context.typography.headlineMedium
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: AppLayout.p3),
            Expanded(
              child: SegmentedController(
              selectedValue: _selectedValue,
              onValueChanged: _onSegmentedControllerValueChanged,
              items: const ['New Exercise', 'Variation'],
              backgroundColor: context.colors.backgroundTertiary,
              // stretch: true,
            ),
            ),
            const SizedBox(height: AppLayout.p4),
            if (_selectedValue == 1) ...[
              FlexPicker(
                formControl: form.baseExerciseControl,
                label: 'Equipment',
                displayValue: (e) => e.name,
                modalRouteName: BaseExercisePicker.routeName,
                padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              ),
              const SizedBox(height: AppLayout.p4),
            ],
            FlexTextField<String>(
              formControl: form.nameControl,
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
              formControl: form.descriptionControl,
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
              formControl: form.videoUrlControl,
              label: 'YouTube Video Demo',
              hintText: 'Enter the YouTube url of a demo video',
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
          ],
        ),
      ),
    );
  }
}
