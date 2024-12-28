import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_controller.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_create_controller.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_form_controller.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_list_controller.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flex_workout_mobile/features/workout/ui/screens/exercise_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class WorkoutCreateFormStepTwo extends ConsumerWidget {
  const WorkoutCreateFormStepTwo({
    required this.back,
    super.key,
  });

  final VoidCallback back;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(workoutFormControllerProvider);
    final model = ref.watch(workoutControllerProvider);

    ref.listen<WorkoutModel?>(workoutCreateControllerProvider,
        (previous, next) {
      if (next == null) return;

      ref.read(workoutListControllerProvider.notifier).addWorkout(next);
      context.pop();
    });

    void submit() {
      ref.read(workoutFormControllerProvider.notifier).create(model);

      ref.invalidate(workoutControllerProvider);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: Text(
            'Exercises',
            style: context.typography.headlineMedium
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: AppLayout.p4),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: model.sections.length,
            itemBuilder: (context, sectionIndex) {
              final section = model.sections[sectionIndex];

              return section.display();
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppLayout.p3),
          ),
        ),
        const SizedBox(height: AppLayout.p3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlexButton(
                onPressed: () =>
                    context.goNamed(WorkoutExerciseSelectionScreen.routeName),
                expanded: true,
                label: 'Add Exercise',
                icon: Symbols.add,
                backgroundColor: context.colors.backgroundPrimary,
              ),
              const SizedBox(height: AppLayout.p3),
              Row(
                children: [
                  FlexButton(
                    onPressed: back,
                    icon: Icons.chevron_left,
                    backgroundColor: context.colors.backgroundTertiary,
                  ),
                  const SizedBox(width: AppLayout.p3),
                  Expanded(
                    child: FlexButton(
                      enabled: form.form.valid,
                      onPressed: submit,
                      label: 'Create Workout',
                      icon: Symbols.add_task,
                      backgroundColor: context.colors.foregroundPrimary,
                      foregroundColor: context.colors.backgroundPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
