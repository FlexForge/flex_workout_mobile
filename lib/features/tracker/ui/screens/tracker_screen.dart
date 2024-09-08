import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/main_tracker_screen.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/workout_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

final trackerScreenObserver = NavigationSheetTransitionObserver();

class TrackerScreenModal extends StatelessWidget {
  const TrackerScreenModal({
    required this.nestedNavigator,
    super.key,
  });

  final Widget nestedNavigator;

  @override
  Widget build(BuildContext context) {
    return DraggableSheet(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: nestedNavigator,
      ),
    );
  }
}

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  static const routePath = 'tracker';
  static const routeName = 'tracker_view';

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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: PageView(
        controller: _pageViewController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MainTrackerScreen(next: () => _updateCurrentPageIndex(2)),
          WorkoutSummaryScreen(
            back: () => _updateCurrentPageIndex(1),
          ),
        ],
      ),
    );
  }
}
