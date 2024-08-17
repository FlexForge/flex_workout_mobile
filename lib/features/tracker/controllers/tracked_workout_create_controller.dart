import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tracked_workout_create_controller.g.dart';

@riverpod
class TrackedWorkoutCreateController extends _$TrackedWorkoutCreateController {
  @override
  TrackedWorkoutModel? build() {
    return null;
  }

  void handle(TrackerForm form, int durationInMinutes) {
    final title = form.model.title;
    final subtitle = form.model.subtitle;
    final notes = form.model.notes ?? '';
    final startTimestamp = form.model.startTimestamp;

    if (title == null ||
        subtitle == null ||
        notes == null ||
        startTimestamp == null) return;

    final res = ref.read(trackedWorkoutRepositoryProvider).createTrackedWorkout(
          title: title,
          subtitle: subtitle,
          notes: notes,
          durationInMinutes: durationInMinutes,
          startTimestamp: startTimestamp,
        );
    state = res.fold((l) => throw l, (r) => r);
  }
}
