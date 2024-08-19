import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracked_workout_filter_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/tracked_workout_list_controller.dart';
import 'package:flex_workout_mobile/features/tracker/extensions/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class WorkoutHistoryList extends ConsumerWidget {
  const WorkoutHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(trackedWorkoutFilterControllerProvider);
    final workoutList = ref.watch(trackedWorkoutListControllerProvider);

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
        : SliverList.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final section = workouts.entries.toList()[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.key,
                      style: context.typography.headlineMedium
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppLayout.p3),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: section.value.length,
                      itemBuilder: (context, index) {
                        final workout = section.value[index];

                        return Section(
                          subHeader: workout.title,
                          body: Container(
                            padding: const EdgeInsets.only(
                              left: AppLayout.p4,
                              right: AppLayout.p4,
                              bottom: AppLayout.p4,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      workout.subtitle,
                                      style: context.typography.labelMedium
                                          .copyWith(
                                        color:
                                            context.colors.foregroundSecondary,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      DateFormat.yMMMEd()
                                          .format(workout.startTimestamp),
                                      style: context.typography.labelMedium
                                          .copyWith(
                                        color:
                                            context.colors.foregroundSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppLayout.p3),
                    ),
                    const SizedBox(height: AppLayout.p6),
                  ],
                ),
              );
            },
          );
  }
}
