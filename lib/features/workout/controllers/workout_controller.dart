import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_controller.g.dart';

@Riverpod(keepAlive: true)
class WorkoutController extends _$WorkoutController {
  @override
  WorkoutModel build() {
    final now = DateTime.now();

    return WorkoutModel(
      id: 0,
      sections: [],
      title: '',
      subtitle: '',
      description: '',
      primaryMuscleGroups: [],
      secondaryMuscleGroups: [],
      createdAt: now,
      updatedAt: now,
    );
  }

  void rebuild() {
    final now = DateTime.now();

    state = WorkoutModel(
      id: 0,
      sections: [],
      title: '',
      subtitle: '',
      description: '',
      primaryMuscleGroups: [],
      secondaryMuscleGroups: [],
      createdAt: now,
      updatedAt: now,
    );
  }

  void addDefaultSection(List<ExerciseModel> exercises) {
    for (final exercise in exercises) {
      final defaultSet = WorkoutDefaultSetModel(
        id: 0,
        exercise: exercise,
        sectionIndex: state.sections.length,
        setIndex: 0,
        minReps: 0,
      );

      final section = WorkoutDefaultSectionModel(
        id: state.sections.length,
        sets: [defaultSet],
        templateSet: defaultSet,
      )..generateTitle(exercise);

      state.sections.add(section);
    }

    _updateMuscleGroups();
  }

  void addSupersetSection(List<ExerciseModel> exercises) {
    final set = <String, IWorkoutSet>{};
    for (final (index, exercise) in exercises.indexed) {
      final key = String.fromCharCode(65 + index);
      final value = WorkoutDefaultSetModel(
        id: 0,
        exercise: exercise,
        sectionIndex: state.sections.length,
        setIndex: 0,
        minReps: 0,
        setString: key,
      );

      set.addAll({key: value});
    }
    final template = Map<String, IWorkoutSet>.from(set);

    final section = WorkoutSupersetSectionModel(
      id: state.sections.length,
      sets: [set],
      templateSet: template,
    )..generateTitle(exercises);

    state.sections.add(section);
    _updateMuscleGroups();
  }

  void addSet(IWorkoutSection section) {
    final index = state.sections.indexOf(section);
    if (index < 0) return;

    switch (state.sections[index]) {
      case final WorkoutDefaultSectionModel section:
        section.sets
            .add(section.templateSet.copyWith(setIndex: section.sets.length));
      case final WorkoutSupersetSectionModel section:
        section.sets.add(
          section.templateSet.map((key, value) {
            return MapEntry(key, value.copyWith(setIndex: section.sets.length));
          }),
        );
    }

    // Force UI to update
    state = state.copyWith(subtitle: state.subtitle);
  }

  void removeSection(IWorkoutSection section) {
    state = state.copyWith(sections: state.sections..remove(section));
    _resetIndexes();
    _updateMuscleGroups();
  }

  void removeDefaultSet(WorkoutDefaultSetModel setToRemove) {
    final section = state.sections[setToRemove.sectionIndex!];

    switch (section) {
      case final WorkoutDefaultSectionModel obj:
        state = state.copyWith.sections.at(setToRemove.sectionIndex!)(
          sets: obj.sets..remove(setToRemove),
        );

      case final WorkoutSupersetSectionModel obj:
        obj.sets[setToRemove.setIndex!]
            .removeWhere((key, value) => key == setToRemove.setString);

        if (obj.sets[setToRemove.setIndex!].isEmpty) {
          state = state.copyWith.sections.at(setToRemove.sectionIndex!)(
            sets: obj.sets..removeAt(setToRemove.setIndex!),
          );
        }
    }

    _resetIndexes();
    _updateMuscleGroups();
  }

  void _resetIndexes() {
    final sections = List<IWorkoutSection>.from(state.sections);
    final newSections =
        sections.mapWithIndex<IWorkoutSection>((section, sectionIndex) {
      switch (section) {
        case final WorkoutDefaultSectionModel obj:
          return obj.copyWith(
            templateSet: obj.templateSet.copyWith(sectionIndex: sectionIndex),
            sets: obj.sets.mapWithIndex((set, setIndex) {
              return set.copyWith(
                sectionIndex: sectionIndex,
                setIndex: setIndex,
              );
            }).toList(),
          );
        case final WorkoutSupersetSectionModel obj:
          return obj.copyWith(
            templateSet: obj.templateSet
              ..updateAll(
                (key, value) => value.copyWith(sectionIndex: sectionIndex),
              ),
            sets: obj.sets.mapWithIndex((set, setIndex) {
              return set
                ..updateAll(
                  (key, value) => value.copyWith(
                    sectionIndex: sectionIndex,
                    setIndex: setIndex,
                  ),
                );
            }).toList(),
          );
      }
    }).toList();

    state = state.copyWith(sections: newSections);
  }

  void _updateMuscleGroups() {
    final exercises =
        state.sections.flatMap((section) => section.getExercises()).toSet();

    final primaryMuscleGroups = exercises.map((exercise) {
      return exercise.primaryMuscleGroups;
    }).fold(<MuscleGroupModel>{}, (previousValue, element) {
      return previousValue.union(element.toSet());
    }).toList();

    final secondaryMuscleGroups = exercises.map((exercise) {
      return exercise.secondaryMuscleGroups;
    }).fold(<MuscleGroupModel>{}, (previousValue, element) {
      return previousValue.union(element.toSet());
    }).toList()
      ..removeWhere(primaryMuscleGroups.contains);

    state = state.copyWith(
      primaryMuscleGroups: primaryMuscleGroups,
      secondaryMuscleGroups: secondaryMuscleGroups,
    );
  }
}
