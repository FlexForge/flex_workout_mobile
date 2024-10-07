import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
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

    void updateSelectedItems(MuscleGroupModel muscleGroup) {
      setState(() {
        if (items.contains(muscleGroup)) {
          items.remove(muscleGroup);
        } else {
          items.add(muscleGroup);
        }
      });
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
                  suffix: Icon(
                    Symbols.check_circle_filled_rounded,
                    size: 20,
                    fill: items.contains(muscleGroup) ? 1 : 0,
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
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: context.colors.divider), // Top border
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: Row(
                children: [
                  Expanded(
                    child: FlexButton(
                      onPressed: () => context.pop(items),
                      label: 'Add Muscle Groups'
                          '${items.isNotEmpty ? ' (${items.length})' : ''}',
                      backgroundColor: context.colors.foregroundPrimary,
                      foregroundColor: context.colors.backgroundPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondaryMuscleGroupsPicker extends ConsumerStatefulWidget {
  const SecondaryMuscleGroupsPicker({super.key});

  static const routePath = 'secondary_muscle_groups';
  static const routeName = 'secondary_muscle_groups_picker';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecondaryMuscleGroupsPickerState();
}

class _SecondaryMuscleGroupsPickerState
    extends ConsumerState<SecondaryMuscleGroupsPicker> {
  final List<MuscleGroupModel> items = [];

  @override
  void initState() {
    final form = ref.read(exerciseFormControllerProvider).muscleGroupsForm;

    if (form.model.secondaryMuscleGroups != null) {
      items.addAll(form.model.secondaryMuscleGroups!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final muscleGroups = ref.watch(muscleGroupListControllerProvider);

    void updateSelectedItems(MuscleGroupModel muscleGroup) {
      setState(() {
        if (items.contains(muscleGroup)) {
          items.remove(muscleGroup);
        } else {
          items.add(muscleGroup);
        }
      });
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
                'Secondary Muscle Groups',
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
                  suffix: Icon(
                    Symbols.check_circle_filled_rounded,
                    size: 20,
                    fill: items.contains(muscleGroup) ? 1 : 0,
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
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: context.colors.divider), // Top border
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: Row(
                children: [
                  Expanded(
                    child: FlexButton(
                      onPressed: () => context.pop(items),
                      label: 'Add Muscle Groups'
                          '${items.isNotEmpty ? ' (${items.length})' : ''}',
                      backgroundColor: context.colors.foregroundPrimary,
                      foregroundColor: context.colors.backgroundPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
