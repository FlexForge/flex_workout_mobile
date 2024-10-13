import 'dart:collection';

import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/history/providers.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'historic_workout_list_controller.g.dart';

class WorkoutHistoryTableCell {
  WorkoutHistoryTableCell(
    this.bestSet, {
    required this.numberOfSets,
    this.superSetIndex,
  });

  final int numberOfSets;
  final IHistoricSet bestSet;
  final int? superSetIndex;
}

@riverpod
class HistoricWorkoutListController extends _$HistoricWorkoutListController {
  @override
  List<HistoricWorkoutModel> build() {
    final res =
        ref.watch(historicWorkoutRepositoryProvider).getHistoricWorkouts();

    return res.fold((l) => throw l, (r) => r);
  }

  void addWorkout(HistoricWorkoutModel workout) {
    state = [...state, workout];
  }

  void deleteWorkout(HistoricWorkoutModel workout) {
    state = state.where((e) => e.id != workout.id).toList();
  }

  List<WorkoutHistoryTableCell> getWorkoutHistoryTable(
    HistoricWorkoutModel workout,
  ) {
    return workout.sections
        .flatMapWithIndex<WorkoutHistoryTableCell>((section, index) {
      switch (section) {
        case final HistoricDefaultSectionModel obj:
          final cell = WorkoutHistoryTableCell(
            obj.bestSet(),
            numberOfSets: obj.sets.length,
          );
          return [cell];
        case final HistoricSupersetSectionModel obj:
          return obj.bestSet().entries.map((entry) {
            final numberOfSets = obj.sets.fold(0, (acc, set) {
              if (set[entry.key] == null) return acc;
              return acc + 1;
            });
            return WorkoutHistoryTableCell(
              entry.value,
              numberOfSets: numberOfSets,
              superSetIndex: index,
            );
          });
      }
    }).toList();
  }
}

extension HashMapGenerator on List<HistoricWorkoutModel> {
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  Map<DateTime, List<HistoricWorkoutModel>> toDateTimeMap() {
    final separatedList = <DateTime, List<HistoricWorkoutModel>>{};

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

  LinkedHashMap<DateTime, List<HistoricWorkoutModel>> toHash(
    DateTime? selectedDay,
  ) {
    final map = toDateTimeMap();

    return LinkedHashMap<DateTime, List<HistoricWorkoutModel>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(map);
  }
}

extension TrackedWorkoutHistoryListToMap on List<HistoricWorkoutModel> {
  Map<String, List<HistoricWorkoutModel>> toFullMap() {
    final separatedList = <DateTime, List<HistoricWorkoutModel>>{};

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

    final sortedSeparatedList = <String, List<HistoricWorkoutModel>>{};
    for (final key in keys) {
      sortedSeparatedList[DateFormat.yMMMM().format(key)] = separatedList[key]!;
    }

    return sortedSeparatedList;
  }

  Map<String, List<HistoricWorkoutModel>> toSingleMap({
    required DateTime selectedDay,
  }) {
    final separatedList = <String, List<HistoricWorkoutModel>>{};

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
