import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/history/providers.dart';
import 'package:fpdart/fpdart.dart';
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

  List<WorkoutHistoryTableCell> getWorkoutHistoryTable(
    HistoricWorkoutModel workout,
  ) {
    return workout.sections
        .flatMapWithIndex<WorkoutHistoryTableCell>((section, index) {
      switch (section) {
        case final HistoricDefaultSectionModel obj:
          final cell = WorkoutHistoryTableCell(
            obj.bestSet(),
            numberOfSets: obj.sets.length,
          );
          return [cell];
        case final HistoricSupersetSectionModel obj:
          return obj.bestSet().values.map(
                (e) => WorkoutHistoryTableCell(
                  e,
                  numberOfSets: obj.sets.length,
                  superSetIndex: index,
                ),
              );
      }
    }).toList();
  }
}

class WorkoutHistoryTableCell {
  WorkoutHistoryTableCell(
    this.bestSet, {
    required this.numberOfSets,
    this.superSetIndex,
  });

  final int numberOfSets;
  final IHistoricSet bestSet;
  final int? superSetIndex;
}
