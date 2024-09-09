import 'package:flex_workout_mobile/core/utils/enums.dart';
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
      sections: [],
    );
  }

  void addSuperSet(List<ExerciseModel> exercises) {
    final setTypes = exercises.mapWithIndex(
      (exercise, index) => CurrentWorkoutSetType(
        sectionIndex: state.sections.length,
        organizerIndex: 0,
        setIndex: index,
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

    state.sections.add(section);
    _updateMuscleGroups();
  }

  void addExercises(List<ExerciseModel> exercises) {
    for (final exercise in exercises) {
      /// Add Set
      final setType = CurrentWorkoutSetType(
        sectionIndex: state.sections.length,
        organizerIndex: 0,
        type: SetTypeEnum.normalSet,
        exercise: exercise,
      );

      final organizer = CurrentWorkoutOrganizer(
        setNumber: 1,
        organization: SetOrganizationEnum.defaultSet,
        defaultSet: setType,
        superSet: [],
      );

      final section = CurrentWorkoutSection(
        title: exercise.name,
        templateOrganizer: organizer,
        organizers: [organizer],
      );

      state.sections.add(section);
    }

    _updateMuscleGroups();
  }

  void addSet(int sectionIndex) {
    final section = state.sections[sectionIndex];
    final setNumber = section.organizers.length + 1;

    section.organizers.add(
      section.templateOrganizer.copyWith(
        setNumber: setNumber,
        superSet: section.templateOrganizer.superSet
            .map(
              (set) => set.copyWith(
                sectionIndex: sectionIndex,
                organizerIndex: section.organizers.length,
              ),
            )
            .toList(),
        defaultSet: section.templateOrganizer.defaultSet?.copyWith(
          sectionIndex: sectionIndex,
          organizerIndex: section.organizers.length,
        ),
      ),
    );
  }

  void addNormalSet(
    NormalSetForm form,
    CurrentWorkoutSetType set,
  ) {
    final section = state.sections[set.sectionIndex];
    final organizer = section.organizers[set.organizerIndex];

    switch (organizer.organization) {
      case SetOrganizationEnum.superSet:
        final setToAdd = organizer.superSet[set.setIndex!].copyWith(
          type: SetTypeEnum.normalSet,
          normalSet: CurrentWorkoutNormalSet(
            reps: form.model.reps!,
            load: form.model.load!,
            units: Units.values[form.model.units!],
          ),
        );

        final superSet = List<CurrentWorkoutSetType>.from(organizer.superSet)
          ..[set.setIndex!] = setToAdd;

        state.sections[set.sectionIndex].organizers[set.organizerIndex] =
            organizer.copyWith(
          superSet: superSet,
        );

      case SetOrganizationEnum.defaultSet:
        final setToAdd = organizer.defaultSet!.copyWith(
          type: SetTypeEnum.normalSet,
          normalSet: CurrentWorkoutNormalSet(
            reps: form.model.reps!,
            load: form.model.load!,
            units: Units.values[form.model.units!],
          ),
        );

        state.sections[set.sectionIndex].organizers[set.organizerIndex] =
            organizer.copyWith(
          defaultSet: setToAdd,
        );
    }

    // Forces the UI to update
    state = state.copyWith(sections: state.sections);
  }

  void removeSection(int index) {
    state.sections.removeAt(index);

    _updateMuscleGroups();
    _resetIndexes();
  }

  void removeDefaultSet(int sectionIndex, int organizerIndex) {
    state.sections[sectionIndex].organizers.removeAt(organizerIndex);

    _resetSetNumbers(sectionIndex);
    _resetIndexes();
  }

  void removeSuperSet(int sectionIndex, int organizerIndex, int superSetIndex) {
    final section = state.sections[sectionIndex];
    final organizer = section.organizers[organizerIndex];

    final superSets = List<CurrentWorkoutSetType>.from(organizer.superSet)
      ..removeAt(superSetIndex);

    if (superSets.isEmpty) {
      section.organizers.remove(organizer);
    } else {
      section.organizers[organizerIndex] = organizer.copyWith(
        superSet: superSets,
      );
    }

    _resetSetNumbers(sectionIndex);
    _resetIndexes();
  }

  void _resetIndexes() {
    final sections = List<CurrentWorkoutSection>.from(state.sections);

    final newSections = sections.mapWithIndex(
      (section, index) => section.copyWith(
        templateOrganizer: section.templateOrganizer.copyWith(
          superSet: section.templateOrganizer.superSet
              .mapWithIndex(
                (set, setIndex) => set.copyWith(
                  sectionIndex: index,
                  setIndex: setIndex,
                ),
              )
              .toList(),
          defaultSet: section.templateOrganizer.defaultSet?.copyWith(
            sectionIndex: index,
          ),
        ),
        organizers: section.organizers
            .mapWithIndex(
              (organizer, organizerIndex) => organizer.copyWith(
                superSet: organizer.superSet
                    .mapWithIndex(
                      (set, setIndex) => set.copyWith(
                        sectionIndex: index,
                        organizerIndex: organizerIndex,
                        setIndex: setIndex,
                      ),
                    )
                    .toList(),
                defaultSet: organizer.defaultSet?.copyWith(
                  sectionIndex: index,
                  organizerIndex: organizerIndex,
                ),
              ),
            )
            .toList(),
      ),
    );

    state = state.copyWith(sections: newSections.toList());
  }

  void _resetSetNumbers(int sectionIndex) {
    final sections = List<CurrentWorkoutSection>.from(state.sections);
    final section = sections[sectionIndex];

    final organizers = section.organizers.mapWithIndex(
      (organizer, index) => organizer.copyWith(setNumber: index + 1),
    );

    sections[sectionIndex] = section.copyWith(organizers: organizers.toList());

    state = state.copyWith(sections: sections);
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
