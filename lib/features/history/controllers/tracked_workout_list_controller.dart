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

extension HashMapGenerator on List<TrackedWorkoutModel> {
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  Map<DateTime, List<TrackedWorkoutModel>> toDateTimeMap() {
    final separatedList = <DateTime, List<TrackedWorkoutModel>>{};

    for (final workout in this) {
      final key = workout.startTimestamp.copyWith(
        hour: 1,
        minute: 1,
        second: 1,
        millisecond: 1,
        microsecond: 1,
      );

      if (separatedList.containsKey(key)) {
        separatedList[key]!.add(workout);
      } else {
        separatedList[key] = [workout];
      }
    }

    return separatedList;
  }

  LinkedHashMap<DateTime, List<TrackedWorkoutModel>> toHash(
    DateTime? selectedDay,
  ) {
    final map = toDateTimeMap();

    return LinkedHashMap<DateTime, List<TrackedWorkoutModel>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(map);
  }
}

extension TrackedWorkoutHistoryListToMap on List<TrackedWorkoutModel> {
  Map<String, List<TrackedWorkoutModel>> toFullMap() {
    final separatedList = <DateTime, List<TrackedWorkoutModel>>{};

    for (final workout in this) {
      final key = workout.startTimestamp.copyWith(
        day: 1,
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );

      if (separatedList.containsKey(key)) {
        separatedList[key]!.add(workout);
      } else {
        separatedList[key] = [workout];
      }
    }

    // Sort each subgroup
    for (final key in separatedList.keys) {
      separatedList[key]!
          .sort((a, b) => a.startTimestamp.isBefore(b.startTimestamp) ? 1 : -1);
    }

    // Sort the keys
    final keys = separatedList.keys.toList()
      ..sort((a, b) => a.isBefore(b) ? 1 : -1);

    final sortedSeparatedList = <String, List<TrackedWorkoutModel>>{};
    for (final key in keys) {
      sortedSeparatedList[DateFormat.yMMMM().format(key)] = separatedList[key]!;
    }

    return sortedSeparatedList;
  }

  Map<String, List<TrackedWorkoutModel>> toSingleMap({
    required DateTime selectedDay,
  }) {
    final separatedList = <String, List<TrackedWorkoutModel>>{};

    final key = DateFormat.yMMMMEEEEd().format(selectedDay);

    for (final workout in this) {
      if (isSameDay(selectedDay, workout.startTimestamp)) {
        if (separatedList.containsKey(key)) {
          separatedList[key]!.add(workout);
        } else {
          separatedList[key] = [workout];
        }
      }
    }

    // Sort each subgroup
    for (final key in separatedList.keys) {
      separatedList[key]!
          .sort((a, b) => a.startTimestamp.isBefore(b.startTimestamp) ? 1 : -1);
    }

    return separatedList;
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
