import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';

extension ExerciseListToMap on List<ExerciseModel> {
  Map<String, List<ExerciseModel>> toMap() {
    final separatedList = <String, List<ExerciseModel>>{};

    for (final exercise in this) {
      final firstChar = exercise.name[0].toUpperCase();
      final key =
          (firstChar.isNotEmpty && RegExp('^[a-zA-Z]').hasMatch(firstChar))
              ? firstChar
              : '#';

      if (separatedList.containsKey(key)) {
        separatedList[key]!.add(exercise);
      } else {
        separatedList[key] = [exercise];
      }
    }

    // Sort each subgroup
    for (final key in separatedList.keys) {
      separatedList[key]!.sort((a, b) => a.name.compareTo(b.name));
    }

    // Sort the keys
    final keys = separatedList.keys.toList()..sort();

    final sortedSeparatedList = <String, List<ExerciseModel>>{};
    for (final key in keys) {
      sortedSeparatedList[key] = separatedList[key]!;
    }

    return sortedSeparatedList;
  }
}
