import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_radio_list_item.dart';
import 'package:flex_workout_mobile/core/common/ui/components/info_card.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_radio_list.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/auth/controllers/onboarding_controller.dart';
import 'package:flex_workout_mobile/features/auth/controllers/user_form_controller.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSetupFormStepThree extends ConsumerWidget {
  const UserSetupFormStepThree({
    required this.back,
    super.key,
  });

  final VoidCallback back;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(userFormControllerProvider);

    return ReactiveUserForm(
      form: form,
      child: FormWrapper(
        backgroundColor: context.colors.backgroundPrimary,
        actionButtons: [
          FlexButton(
            onPressed: back,
            icon: Icons.chevron_left,
            backgroundColor: context.colors.backgroundSecondary,
          ),
          const SizedBox(width: AppLayout.p3),
          ReactiveUserFormConsumer(
            builder: (context, form, child) => Expanded(
              child: FlexButton(
                enabled: form.sexControl?.valid ?? false,
                onPressed: () {
                  ref.read(userFormControllerProvider.notifier).create();
                  ref
                      .read(onboardingControllerProvider.notifier)
                      .setIsFirstLoad(isFirstLoad: false);
                },
                label: 'Go to app',
                icon: Icons.check,
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
                'What is your sex?',
                style: context.typography.titleMedium
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: AppLayout.p4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: FlexRadioList<RadioListItem>(
                formControl: form.sexControl,
                builder: (e, selected, onPressed) => RadioListItem(
                  name: e.name,
                  icon: e.icon,
                  selected: selected,
                  onPressed: onPressed,
                ),
                options: const [
                  RadioListItem(name: 'Female', icon: Icons.female),
                  RadioListItem(name: 'Male', icon: Icons.male),
                ],
              ),
            ),
            const SizedBox(height: AppLayout.p4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: InfoCard(
                icon: Icons.info,
                info: 'Here is a small showcase of a radio list'
                    ' item form control',
                backgroundColor: context.colors.backgroundSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
