import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_list_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracker_form_controller.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/exercise_selection_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseSelectionPicker extends ConsumerStatefulWidget {
  const ExerciseSelectionPicker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExerciseSelectionPickerState();
}

class _ExerciseSelectionPickerState
    extends ConsumerState<ExerciseSelectionPicker> {
  final List<ExerciseModel> items = [];

  void updateSelectedItems(ExerciseModel exercise) {
    setState(() {
      if (items.contains(exercise)) {
        items.remove(exercise);
      } else {
        items.add(exercise);
      }
    });
  }

  void addExercise(List<ExerciseModel> exercises) {
    ref.read(trackerFormControllerProvider.notifier).addExercises(items);
    context.pop();
  }

  void addSuperSet(List<ExerciseModel> exercises) {
    ref.read(trackerFormControllerProvider.notifier).addSuperSet(items);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final sections =
        ref.watch(exerciseSelectionListControllerProvider).toSelectionMap();

    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: ExerciseSelectionTopBar(),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: context.colors.divider), // Top border
          ),
        ),
        child: BottomAppBar(
          color: context.colors.backgroundPrimary,
          padding: EdgeInsets.zero,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: LargeButton(
                    onPressed:
                        items.length > 1 ? () => addSuperSet(items) : null,
                    label: 'Add as Superset',
                    backgroundColor: context.colors.backgroundSecondary,
                    foregroundColor: context.colors.foregroundPrimary,
                  ),
                ),
                const SizedBox(
                  width: AppLayout.p2,
                ),
                Expanded(
                  child: LargeButton(
                    onPressed: () => addExercise(items),
                    label: 'Add Exercises'
                        '${items.isNotEmpty ? ' (${items.length})' : ''}',
                    backgroundColor: context.colors.foregroundPrimary,
                    foregroundColor: context.colors.backgroundPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections.entries.toList()[index];

          return Section(
            header: section.key,
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            body: ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: section.value.length,
              itemBuilder: (context, index) {
                final exercise = section.value[index];

                return FlexListTile(
                  onTap: () => updateSelectedItems(exercise),
                  title: Text(
                    exercise.name,
                    style: context.typography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    'Exercise Information',
                    style: context.typography.bodySmall.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colors.foregroundSecondary,
                    ),
                  ),
                  suffix: items.contains(exercise)
                      ? CircleAvatar(
                          radius: 10,
                          backgroundColor: context.colors.foregroundPrimary,
                          child: Center(
                            child: Text(
                              (items.indexOf(exercise) + 1).toString(),
                              style: context.typography.labelXSmall.copyWith(
                                fontWeight: FontWeight.w700,
                                color: context.colors.backgroundPrimary,
                              ),
                            ),
                          ),
                        )
                      : const Icon(
                          Symbols.check_circle_filled_rounded,
                          size: 20,
                        ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                indent: 54,
                height: 0,
                color: context.colors.divider,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppLayout.p6),
      ),
    );
  }
}
