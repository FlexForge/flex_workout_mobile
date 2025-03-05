import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_controller.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_form_model.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class WorkoutNormalSetInputForm extends ConsumerWidget {
  const WorkoutNormalSetInputForm({
    required this.set,
    super.key,
  });

  final WorkoutDefaultSetModel set;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NormalSetFormBuilder(
      model: NormalSet(
        minReps: set.minReps,
        maxReps: set.maxReps,
      ),
      builder: (context, form, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          normalSetFormHeader(context, ref, set.setIndex! + 1),
          const SizedBox(height: AppLayout.p4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FlexTextField(
                  formControl: form.minRepsControl,
                  label: 'Reps',
                  isRequired: true,
                  hintText: 'Min reps',
                  suffix: const Text('rep(s)'),
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.number,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Min reps are required',
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppLayout.p2,
                  right: AppLayout.p2,
                  top: AppLayout.p5,
                ),
                child: Text(
                  '-',
                  style: context.typography.titleLarge,
                ),
              ),
              Expanded(
                child: FlexTextField(
                  formControl: form.maxRepsControl,
                  label: ' ', // Empty label to keep textfields alined
                  hintText: 'Max reps',
                  suffix: const Text('rep(s)'),
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppLayout.p2),
          // Intensity
          const SizedBox(height: AppLayout.p2),
          // Rest Duration
        ],
      ),
    );
  }

  Widget normalSetFormHeader(
    BuildContext context,
    WidgetRef ref,
    int setIndex,
  ) {
    void onSubmit(NormalSetForm form) {
      ref
          .read(workoutControllerProvider.notifier)
          .completeDefaultSet(form, set);
      context.pop();
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set $setIndex',
                style: context.typography.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                set.exercise.name,
                style: context.typography.labelSmall.copyWith(
                  color: context.colors.foregroundSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppLayout.p4),
        ReactiveNormalSetFormConsumer(
          builder: (context, form, child) {
            return FlexButton(
              onPressed: form.form.valid ? () => onSubmit(form) : null,
              icon: Symbols.check,
              iconSize: 16,
              backgroundColor: context.colors.foregroundPrimary,
              foregroundColor: context.colors.backgroundPrimary,
              borderRadius: AppLayout.roundedRadius,
            );
          },
        ),
      ],
    );
  }
}
