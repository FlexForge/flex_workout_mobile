import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/history/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'historic_workout_list_controller.g.dart';

@riverpod
class HistoricWorkoutListController extends _$HistoricWorkoutListController {
  @override
  List<HistoricWorkoutModel> build() {
    final res =
        ref.watch(historicWorkoutRepositoryProvider).getHistoricWorkouts();

    return res.fold((l) => throw l, (r) => r);
  }

  void addWorkout(HistoricWorkoutModel workout) {
    state = [...state, workout];
  }
}
