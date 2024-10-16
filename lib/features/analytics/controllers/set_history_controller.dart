import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'set_history_controller.g.dart';

@riverpod
class ExerciseSetHistoryController extends _$ExerciseSetHistoryController {
  @override
  Map<DateTime, List<IHistoricSet>> build(String id) {
    final exerciseId = int.tryParse(id);
    if (exerciseId == null) throw const Failure.badRequest();

    final res =
        ref.watch(exerciseRepositoryProvider).getExerciseSets(id: exerciseId);

    final sets = res.fold((l) => throw l, (r) => r);

    /// Group by date
    final separatedList = <DateTime, List<IHistoricSet>>{};
    for (final set in sets.reversed) {
      switch (set) {
        case final HistoricDefaultSetModel defaultSet:
          final key = defaultSet.timeOfCompletion.copyWith(
            hour: 1,
            minute: 1,
            second: 1,
            millisecond: 1,
            microsecond: 1,
          );

          if (separatedList.containsKey(key)) {
            separatedList[key]!.add(set);
          } else {
            separatedList[key] = [set];
          }
      }
    }

    return separatedList;
  }
}
