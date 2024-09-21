import 'dart:collection';

import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/providers.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'tracked_workout_list_controller.g.dart';

@riverpod
class TrackedWorkoutListController extends _$TrackedWorkoutListController {
  @override
  List<TrackedWorkoutModel> build() {
    final res =
        ref.watch(trackedWorkoutRepositoryProvider).getTrackedWorkouts();

    return res.fold((l) => throw l, (r) => r);
  }

  void addWorkout(TrackedWorkoutModel workout) {
    state = [...state, workout];
  }
}

extension WorkoutSectionTile on List<WorkoutSectionModel> {
  int _getNumberOfSets(
    List<SetOrganizerModel> organizers,
    ExerciseModel exercise,
  ) {
    return organizers
        .where(
          (organizer) =>
              organizer.organization == SetOrganizationEnum.superSet &&
              organizer.superSet
                  .where((e) => e.exercise.id == exercise.id)
                  .isNotEmpty,
        )
        .length;
  }

  List<WorkoutHistoryTableCell> toWorkoutHistoryTable() {
    final table = <WorkoutHistoryTableCell>[];
    var superSetIndex = 0;

    for (final section in this) {
      if (section.organizers.isEmpty) {
        continue;
      }

      final organizer = section.organizers.first;

      switch (organizer.organization) {
        case SetOrganizationEnum.defaultSet:
          table.add(
            WorkoutHistoryTableCell(
              organizer.defaultSet!.exercise.name,
              section.organizers.length,
              organizer.defaultSet?.normalSet?.load.toString() ?? 'Error',
            ),
          );
        case SetOrganizationEnum.superSet:
          for (final superSet in section.organizers.first.superSet) {
            table.add(
              WorkoutHistoryTableCell(
                superSet.exercise.name,
                _getNumberOfSets(section.organizers, superSet.exercise),
                '20 lbs x 10',
                superSetIndex: superSetIndex,
              ),
            );
          }
          superSetIndex++;
      }
    }

    return table;
  }
}

class WorkoutHistoryTableCell {
  WorkoutHistoryTableCell(
    this.title,
    this.sets,
    this.bestSet, {
    this.superSetIndex,
  });

  final String title;
  final int sets;
  final String bestSet;
  final int? superSetIndex;
}
