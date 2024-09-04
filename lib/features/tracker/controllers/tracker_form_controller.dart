import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_section_model.dart';
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
      ..titleValueUpdate('Temp Workout')
      ..subtitleValueUpdate('$time Workout')
      ..startTimestampValueUpdate(now);
  }

  void addExercises(List<ExerciseModel> exercises) {
    for (final exercise in exercises) {
      final setType =
          TrackedSetType(type: SetTypeEnum.normalSet, exercise: exercise);
      final organizer = TrackedSetOrganizer(
        setNumber: 1,
        organization: SetOrganizationEnum.defaultSet,
        defaultSet: setType,
      );

      final section =
          TrackedWorkoutSection(title: exercise.name, organizers: [organizer]);
      state.addSectionsItem(section);
    }
  }
}
