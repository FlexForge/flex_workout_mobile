import 'package:flex_workout_mobile/core/common/ui/components/back_button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_create_step_one.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseCreateScreen extends StatefulWidget {
  const ExerciseCreateScreen({super.key});

  static const routeName = 'exercise_create';
  static const routePath = 'exercise/create';

  @override
  State<ExerciseCreateScreen> createState() => _ExerciseCreateScreenState();
}

class _ExerciseCreateScreenState extends State<ExerciseCreateScreen> {
  late PageController _pageController;
  late int currentStep = 1;

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
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            ExerciseCreateFormStepOne(),
          ],
        ),
      ),
    );
  }
}
