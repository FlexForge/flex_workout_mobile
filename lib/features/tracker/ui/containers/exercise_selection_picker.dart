import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/common/ui/components/search_bar.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/core/utils/debouncer.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/containers/exercise_quick_create.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_list_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_search_query_controller.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/exercise_selection_bottom_bar.dart';
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
  final debouncer = Debouncer(milliseconds: 250);

  void updateSelectedItems(ExerciseModel exercise) {
    setState(() {
      if (items.contains(exercise)) {
        items.remove(exercise);
      } else {
        items.add(exercise);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sections =
        ref.watch(exerciseSelectionListControllerProvider).toSelectionMap();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppLayout.p4,
            right: AppLayout.p4,
            bottom: AppLayout.p4,
            top: AppLayout.p4,
          ),
          child: Row(
            children: [
              Expanded(
                child: FlexSearchBar(
                  onChanged: (value) => debouncer.run(
                    () => ref
                        .read(
                          exerciseSelectionSearchQueryControllerProvider
                              .notifier,
                        )
                        .handle(value),
                  ),
                  hintText: 'Search...',
                  prefixIcon: Symbols.search,
                ),
              ),
              const SizedBox(width: AppLayout.p2),
              FlexButton(
                onPressed: () async {
                  final res = await context
                      .pushNamed<ExerciseModel>(ExerciseQuickCreate.routeName);

                  if (res == null) return;
                  items.add(res);
                },
                icon: Icons.add,
                backgroundColor: context.colors.backgroundSecondary,
                foregroundColor: context.colors.foregroundPrimary,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
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
                                  style:
                                      context.typography.labelXSmall.copyWith(
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
        ),
        ExerciseSelectionBottomBar(items: items),
      ],
    );
  }
}
