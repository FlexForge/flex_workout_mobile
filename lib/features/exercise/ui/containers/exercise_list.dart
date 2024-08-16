import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_list_controller.dart';
import 'package:flex_workout_mobile/features/exercise/ui/extensions/list_extensions.dart';
import 'package:flex_workout_mobile/features/exercise/ui/screens/exercise_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExerciseList extends ConsumerWidget {
  const ExerciseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exerciseListControllerProvider).toMap();

    return exercises.isEmpty
        ? SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    color: context.colors.foregroundSecondary,
                    size: 48,
                  ),
                  Text(
                    'No Exercises Found',
                    style: context.typography.headlineMedium.copyWith(
                      color: context.colors.foregroundSecondary,
                    ),
                  ),
                ],
              ),
            ),
          )
        : SliverList.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final section = exercises.entries.toList()[index];

              return Section(
                header: section.key,
                padding: const EdgeInsets.only(
                  left: AppLayout.p4,
                  right: AppLayout.p4,
                  bottom: AppLayout.p6,
                ),
                body: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: section.value.length,
                  itemBuilder: (context, index) {
                    final exercise = section.value[index];

                    return FlexListTile(
                      onTap: () => context.goNamed(
                        ExerciseViewScreen.routeName,
                        pathParameters: {
                          'eid': exercise.id.toString(),
                        },
                      ),
                      title: Text(
                        exercise.name,
                        style: context.typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: exercise.description != null
                          ? Text(
                              exercise.description!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: context.typography.bodySmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.colors.foregroundSecondary,
                              ),
                            )
                          : null,
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
          );
  }
}
