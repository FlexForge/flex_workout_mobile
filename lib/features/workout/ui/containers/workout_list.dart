import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/workout/controllers/workout_list_controller.dart';
import 'package:flex_workout_mobile/features/workout/ui/components/workout_list_tile.dart';
import 'package:flex_workout_mobile/features/workout/ui/screens/workout_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WorkoutList extends ConsumerWidget {
  const WorkoutList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutListControllerProvider).toMap();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppLayout.p6),
        if (workouts.isEmpty)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  color: context.colors.foregroundSecondary,
                  size: 48,
                ),
                Text(
                  'No Workouts Found',
                  style: context.typography.headlineMedium.copyWith(
                    color: context.colors.foregroundSecondary,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final section = workouts.entries.toList()[index];

              return Section(
                header: section.key,
                padding: const EdgeInsets.only(
                  left: AppLayout.p4,
                  right: AppLayout.p4,
                ),
                body: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: section.value.length,
                  itemBuilder: (context, index) {
                    final workout = section.value[index];

                    return WorkoutListTile(
                      workout: workout,
                      onTap: () => context.goNamed(
                        WorkoutViewScreen.routeName,
                        pathParameters: {'wid': workout.id.toString()},
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: 54,
                      height: 0,
                      color: context.colors.divider,
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppLayout.p6),
          ),
      ],
    );
  }
}
