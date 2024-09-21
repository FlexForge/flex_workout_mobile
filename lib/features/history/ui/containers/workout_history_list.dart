import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/history/controllers/historic_workout_list_controller.dart';
import 'package:flex_workout_mobile/features/history/controllers/tracked_workout_filter_controller.dart';
import 'package:flex_workout_mobile/features/history/ui/components/historic_workout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryList extends ConsumerWidget {
  const WorkoutHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(trackedWorkoutFilterControllerProvider);
    final workoutList = ref.watch(historicWorkoutListControllerProvider);

    final workouts = selectedDay != null
        ? workoutList.toSingleMap(selectedDay: selectedDay)
        : workoutList.toFullMap();

    return workouts.isEmpty
        ? SliverToBoxAdapter(
            child: Section(
              header: selectedDay != null
                  ? DateFormat.yMMMMEEEEd().format(selectedDay)
                  : DateFormat.yMMMM().format(DateTime.now()),
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppLayout.p6),
                child: Center(
                  child: Text(
                    'No Workouts Found',
                    style: context.typography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colors.foregroundSecondary,
                    ),
                  ),
                ),
              ),
            ),
          )
        : SliverList.separated(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final section = workouts.entries.toList()[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppLayout.p4),
                    child: Text(
                      section.key,
                      style: context.typography.headlineMedium
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: AppLayout.p3),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: section.value.length,
                    itemBuilder: (context, index) {
                      final workout = section.value[index];

                      return HistoricWorkoutTile(workout: workout);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppLayout.p3),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppLayout.p6),
          );
  }
}
