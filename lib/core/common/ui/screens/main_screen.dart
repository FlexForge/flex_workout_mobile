import 'package:flex_workout_mobile/core/common/ui/components/navigation_bar.dart';
import 'package:flex_workout_mobile/core/common/ui/screens/library_screen.dart';
import 'package:flex_workout_mobile/core/common/ui/screens/settings_screen.dart';
import 'package:flex_workout_mobile/features/dashboard/ui/screens/dashboard_screen.dart';
import 'package:flex_workout_mobile/features/history/ui/screens/workout_history_screen.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/tracker_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoStackedTransition(
      cornerRadius: Tween(begin: 0, end: 16),
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: const <Widget>[
            DashboardScreen(),
            HistoryScreen(),
            LibraryScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: MainNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onTabTapped,
          showToolbarModalBottomSheet: () =>
              context.goNamed(TrackerScreen.routeName),
        ),
      ),
    );
  }
}
