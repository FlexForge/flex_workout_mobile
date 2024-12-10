import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/search_bar.dart';
import 'package:flex_workout_mobile/core/common/ui/components/segment_controller.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/core/utils/debouncer.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_search_query_controller.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/exercise_filters.dart';
import 'package:flex_workout_mobile/features/exercise/ui/containers/exercise_list.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_create_screen.dart';
import 'package:flex_workout_mobile/features/workout/ui/containers/workout_list.dart';
import 'package:flex_workout_mobile/features/workout/ui/screens/workout_create_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  static const routePath = 'library';
  static const routeName = 'library';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  int _selectedValue = 0;
  final debouncer = Debouncer(milliseconds: 250);

  void _onSegmentedControllerValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    void createItem() {
      if (_selectedValue == 1) {
        context.goNamed(WorkoutCreateScreen.routeName);
      } else if (_selectedValue == 2) {
        context.goNamed(ExerciseCreateScreen.routeName);
      }
    }

    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppLayout.p4,
          vertical: AppLayout.p2,
        ),
        color: context.colors.backgroundSecondary,
        child: FlexSearchBar(
          initialValue: ref.read(exerciseSearchQueryControllerProvider),
          onChanged: (value) => debouncer.run(() {
            ref
                .read(exerciseSearchQueryControllerProvider.notifier)
                .handle(value);
          }),
          prefixIcon: Symbols.search,
          hintText: 'Search...',
          backgroundColor: context.colors.backgroundTertiary,
          suffix: _selectedValue == 2
              ? FlexButton(
                  onPressed: () => context.goNamed(ExerciseFilters.routeName),
                  icon: Symbols.sort,
                  backgroundColor: Colors.transparent,
                )
              : null,
        ),
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollBehavior: const CupertinoScrollBehavior(),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'Library',
              style: TextStyle(color: context.colors.foregroundPrimary),
            ),
            backgroundColor: context.colors.backgroundSecondary,
            border: null,
            heroTag: 'library_screen',
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppLayout.p4,
                right: AppLayout.p4,
                top: AppLayout.p6,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SegmentedController(
                      selectedValue: _selectedValue,
                      onValueChanged: _onSegmentedControllerValueChanged,
                      items: const ['Programs', 'Workouts', 'Exercises'],
                      stretch: true,
                    ),
                  ),
                  const SizedBox(width: AppLayout.p4),
                  FlexButton(
                    icon: Symbols.add,
                    padding: const EdgeInsets.all(AppLayout.p3),
                    backgroundColor: context.colors.backgroundSecondary,
                    foregroundColor: context.colors.foregroundPrimary,
                    onPressed: createItem,
                  ),
                ],
              ),
            ),
          ),
          if (_selectedValue == 1)
            const SliverToBoxAdapter(child: WorkoutList()),
          if (_selectedValue == 2) ...[
            const SliverToBoxAdapter(child: ExerciseList()),
          ],
          const SliverToBoxAdapter(
            child: SizedBox(height: AppLayout.bottomBuffer),
          ),
        ],
      ),
    );
  }
}
