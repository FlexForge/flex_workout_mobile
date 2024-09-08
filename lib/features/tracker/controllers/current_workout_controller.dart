import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/current_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_workout_controller.g.dart';

@Riverpod(keepAlive: true)
class CurrentWorkoutController extends _$CurrentWorkoutController {
  @override
  CurrentWorkout build() {
    final now = DateTime.now();
    final time = now.hour < 11
        ? 'Morning'
        : now.hour < 17
            ? 'Afternoon'
            : 'Evening';

    return CurrentWorkout(
      title: 'Temp Workout',
      subtitle: '$time Workout',
      startTimestamp: now,
    );
  }

  void addSuperSet(List<ExerciseModel> exercises) {
    /// Update muscle groups
    // _updateMuscleGroups(exercises);

    final setTypes = exercises.mapWithIndex(
      (exercise, index) => CurrentWorkoutSetType(
        setLetter: String.fromCharCode(65 + index),
        type: SetTypeEnum.normalSet,
        exercise: exercise,
      ),
    );

    final organizer = CurrentWorkoutOrganizer(
      setNumber: 1,
      organization: SetOrganizationEnum.superSet,
      superSet: setTypes.toList(),
    );

    final section = CurrentWorkoutSection(
      title: _getSuperSetName(exercises),
      templateOrganizer: organizer,
      organizers: [organizer],
    );

    state = state.copyWith(sections: [...state.sections, section]);
  }

  void addExercises(List<ExerciseModel> exercises) {
    for (final exercise in exercises) {
      /// Update muscle groups
      // _updateMuscleGroups(exercises);

      /// Add Set
      final setType = CurrentWorkoutSetType(
        type: SetTypeEnum.normalSet,
        exercise: exercise,
      );

      final organizer = CurrentWorkoutOrganizer(
        setNumber: 1,
        organization: SetOrganizationEnum.defaultSet,
        defaultSet: setType,
      );

      final section = CurrentWorkoutSection(
        title: exercise.name,
        templateOrganizer: organizer,
        organizers: [organizer],
      );

      state = state.copyWith(sections: [...state.sections, section]);
    }
  }

  List<WorkoutSummaryTableCell> getWorkoutSummary() {
    final cells = <WorkoutSummaryTableCell>[];

    // var superSetIndex = 0;

    // for (final section in state.sections) {
    //   switch (section.template.organization) {
    //     case SetOrganizationEnum.superSet:
    //       for (final set in section.template.superSet) {
    //         cells.add(
    //           WorkoutSummaryTableCell(
    //             set.exercise,
    //             superSetIndex: superSetIndex,
    //           ),
    //         );
    //       }
    //       superSetIndex++;

    //     case SetOrganizationEnum.defaultSet:
    //       cells.add(
    //         WorkoutSummaryTableCell(
    //           section.template.defaultSet!.exercise,
    //         ),
    //       );
    //   }
    // }

    return cells;
  }
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

class WorkoutSummaryTableCell {
  WorkoutSummaryTableCell(
    this.exercise, {
    this.superSetIndex,
  });

  final ExerciseModel exercise;
  final int? superSetIndex;
}

@Riverpod(keepAlive: true)
class MainTrackerInfoFormController extends _$MainTrackerInfoFormController {
  @override
  MainTrackerInfoForm build() {
    return MainTrackerInfoForm(
      MainTrackerInfoForm.formElements(const MainTrackerInfo()),
      null,
    );
  }
}
