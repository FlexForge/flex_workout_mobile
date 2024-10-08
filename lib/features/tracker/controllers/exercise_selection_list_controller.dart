import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_filter_controller.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/exercise_selection_search_query_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_selection_list_controller.g.dart';

@riverpod
class ExerciseSelectionListController
    extends _$ExerciseSelectionListController {
  @override
  List<ExerciseModel> build() {
    final query = ref.watch(exerciseSelectionSearchQueryControllerProvider);
    final muscleGroups = ref.watch(muscleGroupFilterControllerProvider);
    final equipment = ref.watch(equipmentFilterControllerProvider);
    final movementPattens = ref.watch(movementPatternFilterControllerProvider);

    final muscleGroupIds = muscleGroups.map((group) => group.id).toList();
    final equipmentIndexes =
        equipment.map((equipment) => equipment.index).toList();
    final patternIndexes =
        movementPattens.map((pattern) => pattern.index).toList();

    final res = ref.watch(exerciseRepositoryProvider).getExercises(
          query: query,
          muscleGroupQuery: muscleGroupIds,
          equipmentQuery: equipmentIndexes,
          movementPatternQuery: patternIndexes,
        );

    return res.fold((l) => throw l, (r) => r);
  }

  void addExercise(ExerciseModel exercise) {
    state = [...state, exercise];
  }
}

extension ExerciseSelectionListToMap on List<ExerciseModel> {
  Map<String, List<ExerciseModel>> toSelectionMap() {
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
