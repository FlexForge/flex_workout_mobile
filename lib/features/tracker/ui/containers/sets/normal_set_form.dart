import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_segment_controller.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/live_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/live_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class NormalSetInputForm extends ConsumerWidget {
  const NormalSetInputForm({
    required this.set,
    super.key,
  });

  final LiveDefaultSetModel set;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NormalSetFormBuilder(
      model: NormalSet(
        load: set.load,
        reps: set.reps,
        units: set.units?.index ?? 0,
      ),
      builder: (context, form, child) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          normalSetFormHeader(context, ref),
          const SizedBox(height: AppLayout.p4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FlexTextField(
                  formControl: form.loadControl,
                  label: 'Load',
                  isRequired: true,
                  hintText: 'Enter weight lifted',
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.number,
                  autoFocus: true,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'The load is required',
                  },
                ),
              ),
              const SizedBox(width: AppLayout.p2),
              Column(
                children: [
                  const SizedBox(height: AppLayout.p5),
                  FlexSegmentedControl(
                    formControl: form.unitsControl,
                    options: Units.values.map((e) => e.name).toList(),
                    backgroundColor: context.colors.backgroundPrimary,
                    thumbColor: context.colors.backgroundSecondary,
                    foregroundSelectedColor: context.colors.foregroundPrimary,
                    borderRadius: AppLayout.cornerRadius / 2,
                    thumbBorderColor: context.colors.divider,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppLayout.p4),
          FlexTextField(
            formControl: form.repsControl,
            label: 'Reps',
            isRequired: true,
            hintText: 'Enter reps completed',
            inputAction: TextInputAction.done,
            inputType: TextInputType.number,
            validationMessages: {
              ValidationMessage.required: (error) =>
                  'The number of reps are required',
            },
            suffix: Text(
              'rep(s)',
              style: context.typography.labelMedium
                  .copyWith(color: context.colors.foregroundSecondary),
            ),
          ),
          const SizedBox(height: AppLayout.p4),
        ],
      ),
    );
  }

  Widget normalSetFormHeader(BuildContext context, WidgetRef ref) {
    void onSubmit(NormalSetForm form) {
      ref
          .read(liveWorkoutControllerProvider.notifier)
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
                'Target Weight',
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
            return LargeButton(
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
