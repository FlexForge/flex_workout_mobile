import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:intl/intl.dart';

extension TrackedWorkoutHistoryListToMap on List<TrackedWorkoutModel> {
  Map<String, List<TrackedWorkoutModel>> toMap() {
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
}
