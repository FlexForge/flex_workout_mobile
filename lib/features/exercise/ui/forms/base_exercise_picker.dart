import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/exercise_list_tile.dart';
import 'package:flex_workout_mobile/features/exercise/ui/containers/exercise_list.dart';
import 'package:flex_workout_mobile/features/exercise/ui/extensions/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class BaseExerciseModal extends StatelessWidget {
  const BaseExerciseModal({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollableSheet(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: child,
      ),
    );
  }
}

class BaseExercisePicker extends ConsumerWidget {
  const BaseExercisePicker({super.key});

  static const routePath = 'base_exercise';
  static const routeName = 'base_exercise_picker';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exerciseListControllerProvider).toMap();

    return SheetContentScaffold(
      extendBody: true,
      backgroundColor: context.colors.backgroundPrimary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppLayout.p2),
          child: Row(
            children: [
              const SizedBox(width: AppLayout.p4),
              Text(
                'Exercises',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: context.typography.headlineMedium
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              FlexButton(
                onPressed: context.pop,
                icon: Symbols.close,
                iconSize: 16,
                iconWeight: 700,
                padding: const EdgeInsets.all(AppLayout.p1),
                borderRadius: AppLayout.roundedRadius,
                iconColor: context.colors.foregroundSecondary,
                backgroundColor: context.colors.backgroundTertiary,
              ),
              const SizedBox(width: AppLayout.p4),
            ],
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final section = exercises.entries.toList()[index];

          return Section(
            header: section.key,
            padding: const EdgeInsets.only(
              left: AppLayout.p4,
              right: AppLayout.p4,
            ),
            body: ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: section.value.length,
              itemBuilder: (context, index) {
                final exercise = section.value[index];

                return ExerciseListTile(
                  exercise: exercise,
                  onTap: () => context.pop(exercise),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 54,
                  height: 0,
                  color: context.colors.divider,
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppLayout.p6),
      ),
    );
  }
}
