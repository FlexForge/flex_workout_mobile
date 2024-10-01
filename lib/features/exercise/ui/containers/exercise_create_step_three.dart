import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseCreateFormStepThree extends ConsumerWidget {
  const ExerciseCreateFormStepThree({
    required this.submit,
    required this.back,
    super.key,
  });

  final VoidCallback submit;
  final VoidCallback back;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(exerciseFormControllerProvider).muscleGroupsForm;

    return ReactiveMuscleGroupsForm(
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
          ReactiveMuscleGroupsFormConsumer(
            builder: (context, form, child) => Expanded(
              child: FlexButton(
                enabled: form.form.valid,
                onPressed: submit,
                label: 'Submit',
                icon: Symbols.add_task,
                backgroundColor: context.colors.foregroundPrimary,
                foregroundColor: context.colors.backgroundPrimary,
              ),
            ),
          ),
        ],
        form: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // children: [],
        ),
      ),
    );
  }
}
