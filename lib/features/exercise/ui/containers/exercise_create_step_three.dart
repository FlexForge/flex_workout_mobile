import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_create_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_display.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_field.dart';
import 'package:flex_workout_mobile/features/exercise/ui/forms/primary_muscle_group_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

    ref.listen<ExerciseModel?>(exerciseCreateControllerProvider,
        (previous, next) {
      if (next == null) return;

      ref.read(exerciseListControllerProvider.notifier).addExercise(next);
      context.pop();
    });

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
                label: 'Create Exercise',
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
            ReactiveMuscleGroupsFormConsumer(
              builder: (context, form, child) => Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MuscleGroupDisplay(
                      muscleGroups: frontMuscleGroups,
                      primaryMuscleGroups: form.model.primaryMuscleGroups ?? [],
                      secondaryMuscleGroups:
                          form.model.secondaryMuscleGroups ?? [],
                    ),
                    const SizedBox(width: AppLayout.p4),
                    MuscleGroupDisplay(
                      muscleGroups: backMuscleGroups,
                      primaryMuscleGroups: form.model.primaryMuscleGroups ?? [],
                      secondaryMuscleGroups:
                          form.model.secondaryMuscleGroups ?? [],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppLayout.p6),
            MuscleGroupField(
              formControl: form.primaryMuscleGroupsControl,
              modalRouteName: PrimaryMuscleGroupPicker.routeName,
              label: 'Primary Muscle Groups',
            ),
            const SizedBox(height: AppLayout.p4),
            Divider(
              height: 1,
              color: context.colors.divider,
              thickness: 1,
            ),
            const SizedBox(height: AppLayout.p4),
            MuscleGroupField(
              formControl: form.secondaryMuscleGroupsControl,
              modalRouteName: SecondaryMuscleGroupsPicker.routeName,
              label: 'Secondary Muscle Groups',
            ),
          ],
        ),
      ),
    );
  }
}
