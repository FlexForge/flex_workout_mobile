import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_create_controller.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_form_controller.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_list_controller.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_form_model.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class WorkoutCreateFormStepTwo extends ConsumerWidget {
  const WorkoutCreateFormStepTwo({
    required this.submit,
    required this.back,
    super.key,
  });

  final VoidCallback submit;
  final VoidCallback back;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(workoutFormControllerProvider).exercisesForm;

    ref.listen<WorkoutModel?>(workoutCreateControllerProvider,
        (previous, next) {
      if (next == null) return;

      ref.read(workoutListControllerProvider.notifier).addWorkout(next);
      context.pop();
    });

    return ReactiveExercisesForm(
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
          ReactiveExercisesFormConsumer(
            builder: (context, form, child) => Expanded(
              child: FlexButton(
                enabled: form.form.valid,
                onPressed: submit,
                label: 'Create Workout',
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
            Container(),
          ],
        ),
      ),
    );
  }
}
