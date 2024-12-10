import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/info_card.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/flex_text_field.dart';
import 'package:flex_workout_mobile/core/common/ui/forms/form_wrapper.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_create_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_form_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_list_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class ExerciseQuickCreateModal extends StatelessWidget {
  const ExerciseQuickCreateModal({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DraggableSheet(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: child,
      ),
    );
  }
}

class ExerciseQuickCreate extends ConsumerWidget {
  const ExerciseQuickCreate({super.key});

  static const routePath = 'exercise_quick_create';
  static const trackerRouteName = 'tracker_exercise/quick_create';
  static const workoutRouteName = 'workout_exercise/quick_create';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(exerciseFormControllerProvider).generalForm;

    ref.listen<ExerciseModel?>(exerciseCreateControllerProvider,
        (previous, next) {
      if (next == null) return;

      ref.read(exerciseListControllerProvider.notifier).addExercise(next);
      ref
          .read(exerciseSelectionListControllerProvider.notifier)
          .addExercise(next);

      context.pop(next);
    });

    return SheetContentScaffold(
      backgroundColor: context.colors.backgroundPrimary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          color: context.colors.backgroundPrimary,
          padding: const EdgeInsets.fromLTRB(
            AppLayout.p4,
            AppLayout.p4,
            AppLayout.p4,
            AppLayout.p2,
          ),
          child: Text(
            'Exercise Quick Add',
            textAlign: TextAlign.start,
            style: context.typography.headlineMedium
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ReactiveGeneralForm(
        form: form,
        child: FormWrapper(
          backgroundColor: context.colors.backgroundPrimary,
          padding: const EdgeInsets.only(
            top: AppLayout.p2,
          ),
          actionButtons: [
            ReactiveGeneralFormConsumer(
              builder: (context, form, child) => Expanded(
                child: FlexButton(
                  enabled: form.currentForm.valid,
                  onPressed: () {
                    ref.read(exerciseFormControllerProvider.notifier).create();
                  },
                  label: 'Add Exercise',
                  icon: Symbols.add_task,
                  backgroundColor: context.colors.foregroundPrimary,
                  foregroundColor: context.colors.backgroundPrimary,
                ),
              ),
            ),
          ],
          form: Column(
            children: [
              FlexTextField<String>(
                formControl: form.nameControl,
                label: 'Name',
                hintText: 'Exercise name',
                isRequired: true,
                validationMessages: {
                  ValidationMessage.required: (error) =>
                      'The exercise name is required',
                },
                padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              ),
              const SizedBox(height: AppLayout.p4),
              FlexTextField<String>(
                formControl: form.descriptionControl,
                label: 'Description',
                hintText: 'Describe the exercise, included the setup and the'
                    ' steps required to perform this exercise.',
                isTextArea: true,
                maxCharacters: 1500,
                validationMessages: {
                  ValidationMessage.required: (error) =>
                      'The exercise name is required',
                },
                padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              ),
              const SizedBox(height: AppLayout.p2),
              FlexTextField<String>(
                formControl: form.videoUrlControl,
                label: 'Video Clip',
                hintText: 'Enter the url of a demo video',
                padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              ),
              const SizedBox(height: AppLayout.p4),
              InfoCard(
                padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
                icon: Symbols.info,
                info:
                    'This is the quick way to create an exercise. You can add '
                    'more details later by editing it after your workout',
                backgroundColor: context.colors.backgroundSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
