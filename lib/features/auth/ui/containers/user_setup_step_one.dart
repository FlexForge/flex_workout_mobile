import 'package:flex_workout_mobile/core/common/ui/components/info_card.dart';
import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/auth/controllers/user_form_controller.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class UserSetupFormStepOne extends ConsumerWidget {
  const UserSetupFormStepOne({
    required this.next,
    required this.back,
    super.key,
  });

  final VoidCallback next;
  final VoidCallback back;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(userFormControllerProvider);

    return ReactiveUserForm(
      form: form,
      child: FormWrapper(
        backgroundColor: context.colors.backgroundPrimary,
        actionButtons: [
          LargeButton(
            onPressed: back,
            icon: Icons.chevron_left,
            backgroundColor: context.colors.backgroundSecondary,
          ),
          const SizedBox(width: AppLayout.p3),
          ReactiveUserFormConsumer(
            builder: (context, form, child) => Expanded(
              child: LargeButton(
                enabled: form.nameControl?.valid ?? false,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: Text(
                'Whats your name?',
                style: context.typography.titleMedium
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: AppLayout.p2),
            FlexTextField<String>(
              formControl: form.nameControl,
              hintText: 'Enter your name',
              isRequired: true,
              inputType: TextInputType.name,
              showErrors: (control) => control.invalid && control.dirty,
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'The your name is required',
                'invalidName': (error) => 'Please use your full name',
              },
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            ),
            const SizedBox(height: AppLayout.p4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: InfoCard(
                icon: Icons.info,
                info: 'Please note none of this information is recorded this is'
                    ' just a demo, to showcase a multi page form',
                backgroundColor: context.colors.backgroundSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
