import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/history/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'historic_workout_delete_controller.g.dart';

@riverpod
class HistoricWorkoutDeleteController
    extends _$HistoricWorkoutDeleteController {
  @override
  bool build(HistoricWorkoutModel exercise) {
    return false;
  }

  void handle() {
    final res = ref
        .read(historicWorkoutRepositoryProvider)
        .deleteWorkout(id: exercise.id);

    state = res.fold((l) => throw l, (r) => r);
  }
}
