import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/ui/containers/history_calendar.dart';
import 'package:flex_workout_mobile/features/history/ui/containers/workout_history_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  static const routeName = 'history';
  static const routePath = 'history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollBehavior: const CupertinoScrollBehavior(),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'History',
              style: TextStyle(color: context.colors.foregroundPrimary),
            ),
            backgroundColor: context.colors.backgroundSecondary,
            border: null,
            heroTag: 'history_screen',
          ),
          const SliverToBoxAdapter(
            child: HistoricCalendar(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppLayout.p6),
          ),
          const WorkoutHistoryList(),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppLayout.bottomBuffer),
          ),
        ],
      ),
    );
  }
}
