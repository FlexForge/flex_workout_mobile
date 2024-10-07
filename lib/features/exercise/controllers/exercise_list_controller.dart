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

    final res =
        ref.watch(exerciseRepositoryProvider).getExercises(query: searchQuery);
    return res.fold((l) => throw l, (r) => r);
  }

  void addExercise(ExerciseModel exercise) {
    state = [...state, exercise];
  }
}
