import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
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
    _updateMuscleGroups();
  }

  void addExercises(List<ExerciseModel> exercises) {
    for (final exercise in exercises) {
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

    _updateMuscleGroups();
  }

  void addSet(int sectionIndex) {
    final sections = List<CurrentWorkoutSection>.from(state.sections);
    final section = sections[sectionIndex];

    final organizers = List<CurrentWorkoutOrganizer>.from(section.organizers);

    final setNumber = section.organizers.length + 1;

    final newOrganizer = section.templateOrganizer.copyWith(
      setNumber: setNumber,
    );

    state = state.copyWith(
      sections: sections
        ..removeAt(sectionIndex)
        ..insert(
          sectionIndex,
          section.copyWith(
            organizers: organizers..add(newOrganizer),
          ),
        ),
    );
  }

  void removeSection(int index) {
    final sections = List<CurrentWorkoutSection>.from(state.sections);
    state = state.copyWith(
      sections: sections..removeAt(index),
    );
    _updateMuscleGroups();
  }

  void removeDefaultSet(int sectionIndex, int organizerIndex) {
    final sections = List<CurrentWorkoutSection>.from(state.sections);
    final section = sections[sectionIndex];

    final organizers = List<CurrentWorkoutOrganizer>.from(section.organizers);

    state = state.copyWith(
      sections: sections
        ..removeAt(sectionIndex)
        ..insert(
          sectionIndex,
          section.copyWith(
            organizers: organizers..removeAt(organizerIndex),
          ),
        ),
    );

    _resetSetNumbers(sectionIndex);
  }

  void removeSuperSet(int sectionIndex, int organizerIndex, int superSetIndex) {
    final sections = List<CurrentWorkoutSection>.from(state.sections);
    final section = sections[sectionIndex];

    final organizers = List<CurrentWorkoutOrganizer>.from(section.organizers);
    final organizer = organizers[organizerIndex];

    final superSets = List<CurrentWorkoutSetType>.from(organizer.superSet)
      ..removeAt(superSetIndex);

    if (superSets.isEmpty) {
      state = state.copyWith(
        sections: sections
          ..removeAt(sectionIndex)
          ..insert(
            sectionIndex,
            section.copyWith(
              organizers: organizers..removeAt(organizerIndex),
            ),
          ),
      );
      _resetSetNumbers(sectionIndex);
      return;
    }

    state = state.copyWith(
      sections: sections
        ..removeAt(sectionIndex)
        ..insert(
          sectionIndex,
          section.copyWith(
            organizers: organizers
              ..removeAt(organizerIndex)
              ..insert(organizerIndex, organizer.copyWith(superSet: superSets)),
          ),
        ),
    );
    _resetSetNumbers(sectionIndex);
  }

  void _resetSetNumbers(int sectionIndex) {
    final sections = List<CurrentWorkoutSection>.from(state.sections);
    final section = sections[sectionIndex];

    final organizers = section.organizers.mapWithIndex(
      (organizer, index) => organizer.copyWith(setNumber: index + 1),
    );

    state = state.copyWith(
      sections: sections
        ..removeAt(sectionIndex)
        ..insert(
          sectionIndex,
          section.copyWith(organizers: organizers.toList()),
        ),
    );
  }

  void _updateMuscleGroups() {
    final exercises = _getExercises();

    final primaryMuscleGroups =
        exercises.map((exercise) => exercise.primaryMuscleGroups).fold(
      <MuscleGroupModel>{},
      (previousValue, element) => previousValue.union(element.toSet()),
    ).toList();

    final secondaryMuscleGroups =
        exercises.map((exercise) => exercise.secondaryMuscleGroups).fold(
      <MuscleGroupModel>{},
      (previousValue, element) => previousValue.union(element.toSet()),
    )..removeWhere(primaryMuscleGroups.contains);

    state = state.copyWith(
      primaryMuscleGroups: primaryMuscleGroups,
      secondaryMuscleGroups: secondaryMuscleGroups.toList(),
    );
  }

  List<WorkoutSummaryTableCell> getWorkoutSummary() {
    final cells = <WorkoutSummaryTableCell>[];

    var superSetIndex = 0;

    for (final section in state.sections) {
      switch (section.templateOrganizer.organization) {
        case SetOrganizationEnum.superSet:
          for (final set in section.templateOrganizer.superSet) {
            cells.add(
              WorkoutSummaryTableCell(
                set.exercise,
                superSetIndex: superSetIndex,
              ),
            );
          }
          superSetIndex++;

        case SetOrganizationEnum.defaultSet:
          cells.add(
            WorkoutSummaryTableCell(
              section.templateOrganizer.defaultSet!.exercise,
            ),
          );
      }
    }

    return cells;
  }

  List<ExerciseModel> _getExercises() {
    final exercises = <ExerciseModel>{};

    for (final section in state.sections) {
      switch (section.templateOrganizer.organization) {
        case SetOrganizationEnum.superSet:
          for (final set in section.templateOrganizer.superSet) {
            exercises.add(set.exercise);
          }

        case SetOrganizationEnum.defaultSet:
          exercises.add(section.templateOrganizer.defaultSet!.exercise);
      }
    }

    return exercises.toList();
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
