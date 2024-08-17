import 'package:flex_workout_mobile/core/common/ui/components/drag_handle.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/finished_workout_summary.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/main_tracker.dart';
import 'package:flutter/material.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  static const routePath = 'tracker';

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  late PageController _pageViewController;
  late int currentStep = 1;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
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
      body: ColoredBox(
        color: context.colors.backgroundSecondary,
        child: SafeArea(
          child: Column(
            children: [
              const DragHandle(),
              Expanded(
                child: PageView(
                  controller: _pageViewController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Tracker(next: () => _updateCurrentPageIndex(2)),
                    FinishedWorkoutSummary(
                      back: () => _updateCurrentPageIndex(1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
