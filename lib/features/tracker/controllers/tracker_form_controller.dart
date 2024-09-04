import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
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
      /// Update muscle groups
      final primaryMuscleGroups =
          List<MuscleGroupModel>.from(state.model.primaryMuscleGroups);
      final secondaryMuscleGroups =
          List<MuscleGroupModel>.from(state.model.secondaryMuscleGroups);

      primaryMuscleGroups
        ..addAll(exercise.primaryMuscleGroups)
        ..toSet()
        ..toList();
      secondaryMuscleGroups
        ..addAll(exercise.secondaryMuscleGroups)
        ..toSet()
        ..toList();

      for (final primary in primaryMuscleGroups) {
        if (secondaryMuscleGroups.contains(primary)) {
          secondaryMuscleGroups.remove(primary);
        }
      }

      state
        ..primaryMuscleGroupsValueUpdate(primaryMuscleGroups)
        ..secondaryMuscleGroupsValueUpdate(secondaryMuscleGroups);

      /// Add Set
      final setType = TrackedSetType(exercise: exercise);
      final organizer = TrackedSetOrganizer(
        setNumber: 1,
        organization: SetOrganizationEnum.defaultSet,
        defaultSet: setType,
      );

      final section = TrackedWorkoutSection(
        title: exercise.name,
        template: organizer,
        organizers: [organizer],
      );
      state.addSectionsItem(section);
    }
  }

  void addDefaultSet(TrackedWorkoutSectionForm section) {
    final setNumber = section.model.organizers.length + 1;
    final newSet = section.model.template.copyWith(setNumber: setNumber);

    section.addOrganizersItem(newSet);
  }
}
