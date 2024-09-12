import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/main_tracker_info_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainTrackerHeader extends ConsumerWidget {
  const MainTrackerHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(mainTrackerInfoFormControllerProvider);

    return ReactiveMainTrackerInfoForm(
      form: form,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: FlexTextField(
              formControl: form.titleControl,
              inputAction: TextInputAction.done,
              inputType: TextInputType.name,
              hintText: 'Enter Workout Name',
              contentPadding: EdgeInsets.zero,
              style: context.typography.headlineLarge
                  .copyWith(fontWeight: FontWeight.w700),
              suffix: Icon(
                Symbols.edit,
                size: 20,
                weight: 700,
                color: context.colors.foregroundSecondary,
              ),
              enableBorder: false,
              isRequired: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: FlexTextField(
              formControl: form.notesControl,
              inputAction: TextInputAction.done,
              inputType: TextInputType.name,
              isTextArea: true,
              minLines: 1,
              hintText: 'Add Notes',
              contentPadding: EdgeInsets.zero,
              style: context.typography.bodyMedium.copyWith(
                color: context.colors.foregroundSecondary,
              ),
              enableBorder: false,
              isRequired: true,
            ),
          ),
        ],
      ),
    );
  }
}
