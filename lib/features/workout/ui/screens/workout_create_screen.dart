import 'package:flex_workout_mobile/core/common/ui/components/back_button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_form_controller.dart';
import 'package:flex_workout_mobile/features/workout/ui/containers/workout_create_step_one.dart';
import 'package:flex_workout_mobile/features/workout/ui/containers/workout_create_step_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class WorkoutCreateScreen extends ConsumerStatefulWidget {
  const WorkoutCreateScreen({super.key});

  static const routeName = 'workout_create';
  static const routePath = 'workout/create';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WorkoutCreateScreenState();
}

class _WorkoutCreateScreenState extends ConsumerState<WorkoutCreateScreen> {
  late PageController _pageController;
  late int currentStep = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateCurrentPageIndex(int index) {
    setState(() {
      currentStep = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void submit() {
    ref.read(workoutFormControllerProvider.notifier).create();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundSecondary,
      appBar: CupertinoNavigationBar(
        middle: Text(
          'Create Workout',
          style: TextStyle(color: context.colors.foregroundPrimary),
        ),
        leading: const FlexBackButton(
          icon: Symbols.close,
        ),
        backgroundColor: context.colors.backgroundSecondary,
        border: null,
        padding: EdgeInsetsDirectional.zero,
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            WorkoutCreateFormStepOne(
              next: () => _updateCurrentPageIndex(1),
            ),
            WorkoutCreateFormStepTwo(
              submit: submit,
              back: () => _updateCurrentPageIndex(0),
            ),
          ],
        ),
      ),
    );
  }
}
