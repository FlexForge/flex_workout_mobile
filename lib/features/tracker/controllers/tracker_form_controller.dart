import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tracker_form_controller.g.dart';

@Riverpod(keepAlive: true)
class TrackerFormController extends _$TrackerFormController {
  @override
  TrackerForm build() {
    return TrackerForm(TrackerForm.formElements(const Tracker()), null);
  }

  void fillNewEmptyWorkout() {
    final now = DateTime.now();
    final time = now.hour < 11
        ? 'Morning'
        : now.hour < 17
            ? 'Afternoon'
            : 'Evening';

    state
      ..subtitleValueUpdate('$time Workout')
      ..startTimestampValueUpdate(now);
  }
}
