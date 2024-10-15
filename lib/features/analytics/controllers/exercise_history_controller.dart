import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_history_controller.g.dart';

@riverpod
class ExerciseHistoryController extends _$ExerciseHistoryController {
  @override
  List<IHistoricSet> build(String id) {
    final exerciseId = int.tryParse(id);
    if (exerciseId == null) throw const Failure.badRequest();

    final res =
        ref.watch(exerciseRepositoryProvider).getExerciseSets(id: exerciseId);

    return res.fold((l) => throw l, (r) => r);
  }
}
