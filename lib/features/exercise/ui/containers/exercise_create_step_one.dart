import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class ExerciseCreateFormStepOne extends ConsumerWidget {
  const ExerciseCreateFormStepOne({required this.next, super.key});

  final VoidCallback next;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              label: 'Video Clip',
              hintText: 'Enter the url of a demo video',
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
          ],
        ),
      ),
    );
  }
}
