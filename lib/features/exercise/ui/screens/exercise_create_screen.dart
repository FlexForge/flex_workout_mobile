import 'package:flex_workout_mobile/core/common/ui/components/back_button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_form_controller.dart';
import 'package:flex_workout_mobile/features/exercise/ui/containers/exercise_create_step_one.dart';
import 'package:flex_workout_mobile/features/exercise/ui/containers/exercise_create_step_three.dart';
import 'package:flex_workout_mobile/features/exercise/ui/containers/exercise_create_step_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseCreateScreen extends ConsumerStatefulWidget {
  const ExerciseCreateScreen({super.key});

  static const routeName = 'exercise_create';
  static const routePath = 'exercise/create';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExerciseCreateScreenState();
}

class _ExerciseCreateScreenState extends ConsumerState<ExerciseCreateScreen> {
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
    ref.read(exerciseFormControllerProvider.notifier).create();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundSecondary,
      appBar: CupertinoNavigationBar(
        middle: Text(
          'Create Exercise',
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
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            ExerciseCreateFormStepOne(next: () => _updateCurrentPageIndex(1)),
            ExerciseCreateFormStepTwo(
              next: () => _updateCurrentPageIndex(2),
              back: () => _updateCurrentPageIndex(0),
            ),
            ExerciseCreateFormStepThree(
              submit: submit,
              back: () => _updateCurrentPageIndex(1),
            ),
          ],
        ),
      ),
    );
  }
}
