import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/auth/ui/components/onboarding_getting_started.dart';
import 'package:flex_workout_mobile/features/auth/ui/components/onboarding_intro.dart';
import 'package:flex_workout_mobile/features/auth/ui/containers/user_setup_step_one.dart';
import 'package:flex_workout_mobile/features/auth/ui/containers/user_setup_step_three.dart';
import 'package:flex_workout_mobile/features/auth/ui/containers/user_setup_step_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routePath = 'onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageViewController;
  late int currentStep = 1;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    _pageViewController.dispose();
  }

  void _updateCurrentPageIndex(int index) {
    setState(() {
      currentStep = index;
    });

    _pageViewController.animateToPage(
      index - 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: SafeArea(
        child: PageView(
          controller: _pageViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            OnboardingIntro(next: () => _updateCurrentPageIndex(2)),
            OnboardingStepOne(
              next: () => _updateCurrentPageIndex(3),
            ),
            UserSetupFormStepOne(
              next: () => _updateCurrentPageIndex(4),
              back: () => _updateCurrentPageIndex(2),
            ),
            UserSetupFormStepTwo(
              next: () => _updateCurrentPageIndex(5),
              back: () => _updateCurrentPageIndex(3),
            ),
            UserSetupFormStepThree(
              back: () => _updateCurrentPageIndex(4),
            ),
          ],
        ),
      ),
    );
  }
}
