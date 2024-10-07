import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_radio_list_item.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/muscle_group_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class ExerciseSelectionFiltersModal extends StatelessWidget {
  const ExerciseSelectionFiltersModal({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DraggableSheet(
      initialExtent: const Extent.proportional(0.5),
      minExtent: const Extent.proportional(0.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: child,
      ),
    );
  }
}

class ExerciseSelectionFilters extends StatefulWidget {
  const ExerciseSelectionFilters({super.key});

  static const routePath = 'exercise_selection_filters';
  static const routeName = 'exercise_selection_filters';

  @override
  State<ExerciseSelectionFilters> createState() =>
      _ExerciseSelectionFiltersState();
}

class _ExerciseSelectionFiltersState extends State<ExerciseSelectionFilters>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: Column(
        children: [
          const SizedBox(height: AppLayout.p4),
          Row(
            children: [
              const SizedBox(width: AppLayout.p4),
              Text(
                'Filters',
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
              const SizedBox(width: AppLayout.p2),
            ],
          ),
          // const SizedBox(height: AppLayout.p2),
          ColoredBox(
            color: context.colors.backgroundPrimary,
            child: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      const Icon(Symbols.workspaces, size: 20),
                      const SizedBox(width: AppLayout.p1),
                      Text(
                        'Muscle Groups',
                        style: context.typography.labelMedium,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Icon(Symbols.exercise, size: 20),
                      const SizedBox(width: AppLayout.p1),
                      Text(
                        'Equipment',
                        style: context.typography.labelMedium,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Icon(Symbols.directions_run, size: 20, weight: 700),
                      const SizedBox(width: AppLayout.p1),
                      Text(
                        'Movement Patterns',
                        style: context.typography.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: context.colors.foregroundPrimary,
              indicatorColor: context.colors.foregroundPrimary,
              unselectedLabelColor: context.colors.foregroundSecondary,
              dividerColor: context.colors.divider,
              indicatorWeight: 3,
              overlayColor: WidgetStateProperty.all(
                context.colors.backgroundTertiary,
              ),
              dividerHeight: 1,
              tabAlignment: TabAlignment.center,
            ),
          ),
          const SizedBox(height: AppLayout.p4),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                MuscleGroupsFilter(),
                EquipmentFilter(),
                MovementPatternFilter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MuscleGroupsFilter extends ConsumerWidget {
  const MuscleGroupsFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muscleGroups = ref.watch(muscleGroupListControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p2),
      child: LayoutGrid(
        gridFit: GridFit.loose,
        columnGap: AppLayout.p2,
        rowGap: AppLayout.p2,
        columnSizes: [1.fr, 1.fr],
        rowSizes: List.generate(10, (_) => auto),
        children: [
          RadioListItem(
            onPressed: () =>
                ref.read(muscleGroupFilterControllerProvider.notifier).clear(),
            selected: ref.watch(muscleGroupFilterControllerProvider).isEmpty,
            padding: const EdgeInsets.only(right: AppLayout.p1),
            name: 'All',
            icon: Symbols.apps,
            value: null,
          ),
          ...muscleGroups.map(
            (group) => RadioListItem(
              onPressed: () => ref
                  .read(muscleGroupFilterControllerProvider.notifier)
                  .handle(group),
              selected: ref
                  .watch(muscleGroupFilterControllerProvider)
                  .contains(group),
              padding: const EdgeInsets.only(right: AppLayout.p1),
              name: group.name,
              icon: Symbols.brightness_1,
              value: null,
            ),
          ),
        ],
      ),
    );
  }
}

class EquipmentFilter extends ConsumerWidget {
  const EquipmentFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p2),
      child: LayoutGrid(
        gridFit: GridFit.loose,
        columnGap: AppLayout.p2,
        rowGap: AppLayout.p2,
        columnSizes: [1.fr, 1.fr],
        rowSizes: List.generate(5, (_) => auto),
        children: [
          RadioListItem(
            onPressed: () =>
                ref.read(equipmentFilterControllerProvider.notifier).clear(),
            selected: ref.watch(equipmentFilterControllerProvider).isEmpty,
            padding: const EdgeInsets.only(right: AppLayout.p1),
            name: 'All',
            icon: Symbols.apps,
            value: null,
          ),
          ...Equipment.values.map(
            (equipment) => RadioListItem(
              onPressed: () => ref
                  .read(equipmentFilterControllerProvider.notifier)
                  .handle(equipment),
              selected: ref
                  .watch(equipmentFilterControllerProvider)
                  .contains(equipment),
              padding: const EdgeInsets.only(right: AppLayout.p1),
              name: equipment.readableName,
              icon: Symbols.brightness_1,
              value: null,
            ),
          ),
        ],
      ),
    );
  }
}

class MovementPatternFilter extends ConsumerWidget {
  const MovementPatternFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p2),
      child: LayoutGrid(
        gridFit: GridFit.loose,
        columnGap: AppLayout.p2,
        rowGap: AppLayout.p2,
        columnSizes: [1.fr, 1.fr],
        rowSizes: List.generate(8, (_) => auto),
        children: [
          RadioListItem(
            onPressed: () => ref
                .read(movementPatternFilterControllerProvider.notifier)
                .clear(),
            selected:
                ref.watch(movementPatternFilterControllerProvider).isEmpty,
            padding: const EdgeInsets.only(right: AppLayout.p1),
            name: 'All',
            icon: Symbols.apps,
            value: null,
          ),
          ...MovementPattern.values.map(
            (pattern) => RadioListItem(
              onPressed: () => ref
                  .read(movementPatternFilterControllerProvider.notifier)
                  .handle(pattern),
              selected: ref
                  .watch(movementPatternFilterControllerProvider)
                  .contains(pattern),
              padding: const EdgeInsets.only(right: AppLayout.p1),
              name: pattern.readableName,
              icon: Symbols.brightness_1,
              value: null,
            ),
          ),
        ],
      ),
    );
  }
}
