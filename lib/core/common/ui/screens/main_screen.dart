import 'package:flex_workout_mobile/core/common/ui/components/navigation_bar.dart';
import 'package:flex_workout_mobile/core/common/ui/screens/library_screen.dart';
import 'package:flex_workout_mobile/core/common/ui/screens/settings_screen.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/dashboard/ui/screens/dashboard_screen.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/tracker_screen.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/workout_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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

  void _showToolbarModalBottomSheet(BuildContext context) {
    showCupertinoModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      barrierColor: context.colors.overlay,
      elevation: 0,
      builder: (context) => const TrackerScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _showToolbarModalBottomSheet(context),
      ),
    );
  }
}
