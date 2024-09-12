import 'package:flex_workout_mobile/features/tracker/data/models/current_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tracked_workout_create_controller.g.dart';

@riverpod
class TrackedWorkoutCreateController extends _$TrackedWorkoutCreateController {
  @override
  TrackedWorkoutModel? build() {
    return null;
  }

  void handle(MainTrackerInfoForm infoForm, LiveWorkoutModel workout) {
    // final title = infoForm.model.title ?? workout.title;
    // final notes = infoForm.model.notes ?? workout.notes;

    // final res = ref
    //     .read(trackedWorkoutRepositoryProvider)
    //     .createTrackedWorkout(title: title, notes: notes, workout: workout);
    // state = res.fold((l) => throw l, (r) => r);
  }
}
