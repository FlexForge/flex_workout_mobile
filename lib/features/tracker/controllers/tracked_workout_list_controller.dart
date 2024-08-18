import 'dart:collection';

import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/providers.dart';
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

  LinkedHashMap<DateTime, List<TrackedWorkoutModel>> toHash() {
    final map = toDateTimeMap();

    return LinkedHashMap<DateTime, List<TrackedWorkoutModel>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(map);
  }
}
