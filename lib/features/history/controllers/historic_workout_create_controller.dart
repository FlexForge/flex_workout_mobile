import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:flex_workout_mobile/features/history/providers.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/live_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'historic_workout_create_controller.g.dart';

@riverpod
class HistoricWorkoutCreateController
    extends _$HistoricWorkoutCreateController {
  @override
  HistoricWorkoutModel? build() {
    return null;
  }

  void handle(MainTrackerInfoForm infoForm, LiveWorkoutModel workout) {
    final title = infoForm.model.title ?? 'Unnamed Workout';
    final notes = infoForm.model.notes ?? '';

    final res = ref
        .read(historicWorkoutRepositoryProvider)
        .createdHistoricWorkout(title: title, notes: notes, workout: workout);

    state = res.fold((l) => throw l, (r) => r);
  }
}
