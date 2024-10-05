import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/segment_controller.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/ui/containers/exercise_list.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_create_screen.dart';
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
  void _onSegmentedControllerValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    void createItem() {
      if (_selectedValue == 2) {
        context.goNamed(ExerciseCreateScreen.routeName);
      }
    }

    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
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
              padding: const EdgeInsets.symmetric(
                horizontal: AppLayout.p4,
                vertical: AppLayout.p6,
              ),
              child: Row(
                children: [
                  SegmentedController(
                    selectedValue: _selectedValue,
                    onValueChanged: _onSegmentedControllerValueChanged,
                    items: const ['Programs', 'Workouts', 'Exercises'],
                  ),
                  const Spacer(),
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
          if (_selectedValue == 2) const ExerciseList(),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppLayout.bottomBuffer),
          ),
        ],
      ),
    );
  }
}
