import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/muscle_group_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class MuscleGroupModal extends StatelessWidget {
  const MuscleGroupModal({required this.child, super.key});

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

class PrimaryMuscleGroupPicker extends ConsumerStatefulWidget {
  const PrimaryMuscleGroupPicker({super.key});

  static const routePath = 'primary_muscle_groups';
  static const routeName = 'primary_muscle_groups_picker';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrimaryMuscleGroupPickerState();
}

class _PrimaryMuscleGroupPickerState
    extends ConsumerState<PrimaryMuscleGroupPicker> {
  final List<MuscleGroupModel> items = [];

  @override
  void initState() {
    final form = ref.read(exerciseFormControllerProvider).muscleGroupsForm;

    if (form.model.primaryMuscleGroups != null) {
      items.addAll(form.model.primaryMuscleGroups!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final muscleGroups = ref.watch(muscleGroupListControllerProvider);
    final form = ref.watch(exerciseFormControllerProvider).muscleGroupsForm;

    void updateSelectedItems(MuscleGroupModel muscleGroup) {
      setState(() {
        if (items.contains(muscleGroup)) {
          items.remove(muscleGroup);
        } else {
          items.add(muscleGroup);
        }
      });

      form.primaryMuscleGroupsValueUpdate(items);
    }

    return SheetContentScaffold(
      backgroundColor: context.colors.backgroundSecondary,
      body: Column(
        children: [
          const SizedBox(height: AppLayout.p2),
          Row(
            children: [
              const SizedBox(width: AppLayout.p4),
              Text(
                'Primary Muscle Groups',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: context.typography.headlineMedium
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              FlexButton(
                onPressed: context.pop,
                icon: Symbols.close,
                padding: const EdgeInsets.all(AppLayout.p2),
                borderRadius: AppLayout.roundedRadius,
                backgroundColor: context.colors.backgroundTertiary,
              ),
              const SizedBox(width: AppLayout.p4),
            ],
          ),
          const SizedBox(height: AppLayout.p2),
          Expanded(
            child: ListView.separated(
              itemCount: muscleGroups.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final muscleGroup = muscleGroups[index];
                return FlexListTile(
                  onTap: () => updateSelectedItems(muscleGroup),
                  title: Text(
                    muscleGroup.name,
                    style: context.typography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  suffix: items.contains(muscleGroup)
                      ? CircleAvatar(
                          radius: 10,
                          backgroundColor: context.colors.foregroundPrimary,
                          child: Center(
                            child: Text(
                              (items.indexOf(muscleGroup) + 1).toString(),
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
          ),
          // ExerciseSelectionBottomBar(items: items),
        ],
      ),
    );
  }
}
