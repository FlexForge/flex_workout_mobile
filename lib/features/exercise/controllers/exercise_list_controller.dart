import 'package:flex_workout_mobile/features/exercise/controllers/exercise_filter_controller.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_search_query_controller.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_list_controller.g.dart';

@riverpod
class ExerciseListController extends _$ExerciseListController {
  @override
  List<ExerciseModel> build() {
    final searchQuery = ref.watch(exerciseSearchQueryControllerProvider);
    final muscleGroups = ref.watch(muscleGroupFilterControllerProvider);
    final equipment = ref.watch(equipmentFilterControllerProvider);
    final movementPattens = ref.watch(movementPatternFilterControllerProvider);

    final muscleGroupIds = muscleGroups.map((group) => group.id).toList();
    final equipmentIndexes =
        equipment.map((equipment) => equipment.index).toList();
    final patternIndexes =
        movementPattens.map((pattern) => pattern.index).toList();

    final res = ref.watch(exerciseRepositoryProvider).getExercises(
          query: searchQuery,
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
