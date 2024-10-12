import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/history/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'historic_workout_view_controller.g.dart';

@riverpod
class HistoricWorkoutViewController extends _$HistoricWorkoutViewController {
  @override
  HistoricWorkoutModel build(String id) {
    final workoutId = int.tryParse(id);
    if (workoutId == null) throw const Failure.badRequest();

    final res =
        ref.watch(historicWorkoutRepositoryProvider).getWorkoutById(workoutId);

    return res.fold(
      (l) => throw l,
      (r) => r,
    );
  }
}
