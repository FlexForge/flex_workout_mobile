import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_section_model.dart';
import 'package:fpdart/fpdart.dart';
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

  void addSuperSet(List<ExerciseModel> exercises) {
    /// Update muscle groups
    _updateMuscleGroups(exercises);

    final setTypes = exercises.mapWithIndex(
      (exercise, index) => TrackedSetType(
        setLetter: String.fromCharCode(65 + index),
        exercise: exercise,
      ),
    );

    final organizer = TrackedSetOrganizer(
      setNumber: 1,
      organization: SetOrganizationEnum.superSet,
      superSet: setTypes.toList(),
      defaultSet: setTypes.first, // This has to be set for a dumb reason0
    );

    final section = TrackedWorkoutSection(
      title: _getSuperSetName(exercises),
      template: organizer,
      organizers: [organizer],
    );

    state.addSectionsItem(section);
  }

  void addExercises(List<ExerciseModel> exercises) {
    for (final exercise in exercises) {
      /// Update muscle groups
      _updateMuscleGroups(exercises);

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

  String _getSuperSetName(List<ExerciseModel> exercises) {
    final name = StringBuffer();

    for (final exercise in exercises) {
      name.write(exercise.name);

      if (exercises.last != exercise) {
        name.write(' & ');
      } else {
        name.write(' Superset');
      }
    }

    return name.toString();
  }

  void _updateMuscleGroups(List<ExerciseModel> exercises) {
    for (final exercise in exercises) {
      /// Update muscle groups
      final primaryMuscleGroups =
          List<MuscleGroupModel>.from(state.model.primaryMuscleGroups);
      final secondaryMuscleGroups =
          List<MuscleGroupModel>.from(state.model.secondaryMuscleGroups);

      primaryMuscleGroups.addAll(exercise.primaryMuscleGroups);
      secondaryMuscleGroups.addAll(exercise.secondaryMuscleGroups);

      final uniquePrimaryMuscleGroups = primaryMuscleGroups.toSet().toList();
      final uniqueSecondaryMuscleGroups =
          secondaryMuscleGroups.toSet().toList();

      for (final primary in uniquePrimaryMuscleGroups) {
        if (uniqueSecondaryMuscleGroups.contains(primary)) {
          uniqueSecondaryMuscleGroups.remove(primary);
        }
      }

      state
        ..primaryMuscleGroupsValueUpdate(uniquePrimaryMuscleGroups)
        ..secondaryMuscleGroupsValueUpdate(uniqueSecondaryMuscleGroups);
    }
  }
}
