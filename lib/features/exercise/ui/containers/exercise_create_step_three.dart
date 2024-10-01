import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/core/config/router.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/flex_picker.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_display.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/muscle_group_view.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/primary_muscle_group_picker.dart';
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
            const SizedBox(height: AppLayout.p4),
            ReactiveMuscleGroupsFormConsumer(
              builder: (context, form, child) {
                return FlexPicker(
                  padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
                  formControl: form.primaryMuscleGroupsControl,
                  label: 'Primary Muscle Groups',
                  display: (muscleGroups) => Column(
                    children: [
                      if (muscleGroups != null)
                        ...muscleGroups.map(
                          (muscle) => FlexListTile(title: Text(muscle.name)),
                        ),
                      FlexButton(
                        onPressed: () =>
                            context.goNamed(PrimaryMuscleGroupPicker.routeName),
                        expanded: true,
                        label: 'Add Muscle Group',
                        icon: Symbols.add,
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
