import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/analytics/controllers/set_history_controller.dart';
import 'package:flex_workout_mobile/features/analytics/data/models/line_graph_model.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_history_controller.g.dart';

@riverpod
class ExerciseMaxLoadController extends _$ExerciseMaxLoadController {
  @override
  List<LineGraphPoint<DateTime>> build(String id) {
    final sets = ref.watch(exerciseSetHistoryControllerProvider(id));

    final points = sets.values.take(7).map((set) {
      final setToUse = set.fold(set.first, (prev, e) {
        if (prev.getMaxLoad() > e.getMaxLoad()) return prev;
        return e;
      }) as HistoricDefaultSetModel;

      return LineGraphPoint<DateTime>(
        xAxis: setToUse.timeOfCompletion,
        yAxis: setToUse.getMaxLoad(),
      );
    }).toList();

    return points;
  }
}

@riverpod
class ExerciseOneRmController extends _$ExerciseOneRmController {
  @override
  List<LineGraphPoint<DateTime>> build(String id) {
    final sets = ref.watch(exerciseSetHistoryControllerProvider(id));

    final points = sets.values.take(7).map((set) {
      final setToUse = set.fold(set.first, (prev, e) {
        if (prev.getOneRepMax() > e.getOneRepMax()) return prev;
        return e;
      }) as HistoricDefaultSetModel;

      return LineGraphPoint(
        xAxis: setToUse.timeOfCompletion,
        yAxis: setToUse.getOneRepMax(),
      );
    }).toList();

    return points;
  }
}
