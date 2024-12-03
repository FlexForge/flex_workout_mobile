import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_form_controller.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class WorkoutCreateFormStepOne extends ConsumerWidget {
  const WorkoutCreateFormStepOne({required this.next, super.key});

  final VoidCallback next;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(workoutFormControllerProvider).generalForm;

    return ReactiveGeneralForm(
      form: form,
      child: FormWrapper(
        backgroundColor: context.colors.backgroundSecondary,
        actionButtons: [
          ReactiveGeneralFormConsumer(
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
          children: [
            FlexTextField<String>(
              formControl: form.nameControl,
              label: 'Name',
              hintText: 'Workout name',
              isRequired: true,
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'The workout name is required',
              },
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
            const SizedBox(height: AppLayout.p4),
            FlexTextField<String>(
              formControl: form.focusControl,
              label: 'Focus',
              hintText: 'Workout focus (i.e. Strength)',
              isRequired: true,
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'The workout focus is required',
              },
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
            const SizedBox(height: AppLayout.p4),
            // TODO: Program select
            FlexTextField<String>(
              formControl: form.descriptionControl,
              label: 'Description',
              hintText: 'Describe the workout, included the setup and the'
                  ' steps required to perform this workout.',
              isTextArea: true,
              maxCharacters: 1500,
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'The workout name is required',
              },
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
          ],
        ),
      ),
    );
  }
}
