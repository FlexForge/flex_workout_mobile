import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_segment_controller.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/current_workout_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class NormalSetInputForm extends ConsumerWidget {
  const NormalSetInputForm({
    required this.sectionIndex,
    required this.organizerIndex,
    this.setIndex,
    super.key,
  });

  final int sectionIndex;
  final int organizerIndex;
  final int? setIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NormalSetFormBuilder(
      model: const NormalSet(units: 0),
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
                ),
              ),
              const SizedBox(width: AppLayout.p2),
              Column(
                children: [
                  const SizedBox(height: AppLayout.p5),
                  FlexSegmentedControl(
                    formControl: form.unitsControl,
                    options: [Units.lbs.name, Units.kgs.name],
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
            suffix: Text(
              'rep(s)',
              style: context.typography.labelMedium
                  .copyWith(color: context.colors.foregroundSecondary),
            ),
          ),
          const SizedBox(height: AppLayout.p4),
          ReactiveNormalSetFormConsumer(
            builder: (context, form, child) {
              return Text(form.form.value.toString());
            },
          ),
          const SizedBox(height: AppLayout.p4),
        ],
      ),
    );
  }

  Widget normalSetFormHeader(BuildContext context, WidgetRef ref) {
    void onSubmit(NormalSetForm form) {
      ref
          .read(currentWorkoutControllerProvider.notifier)
          .addNormalSet(form, sectionIndex, organizerIndex, setIndex);
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
                '195-200 lbs x 1 rep',
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
              iconSize: 18,
              padding: const EdgeInsets.all(AppLayout.p2),
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
