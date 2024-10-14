import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_controller.g.dart';

@Riverpod(keepAlive: true)
class WorkoutController extends _$WorkoutController {
  @override
  WorkoutModel build() {
    final now = DateTime.now();

    var time = 'Evening';
    if (now.hour < 17) time = 'Afternoon';
    if (now.hour < 11) time = 'Morning';
    if (now.hour < 5) time = 'Night';

    return WorkoutModel(
      sections: [],
      subtitle: '$time Workout',
      startTimestamp: now,
    );
  }

  void addNewExercise(ExerciseModel exercise) {
    final exerciseList = List<ExerciseModel>.from(state.newExercises);
    state = state.copyWith(newExercises: exerciseList..add(exercise));
  }

  void addDefaultSection(List<ExerciseModel> exercises) {
    for (final exercise in exercises) {
      final sectionToAdd = DefaultSectionModel(sets: [], exercise: exercise);
      state.sections.add(sectionToAdd);
      _updateMuscleGroups();
    }
  }

  void addSupersetSection(List<ExerciseModel> exercises) {
    final sectionToAdd = SupersetSectionModel(sets: [], exercises: exercises);
    state.sections.add(sectionToAdd);
    _updateMuscleGroups();
  }

  void addDefaultSet(ISection section) {
    final index = state.sections.indexOf(section);
    if (index < 0) return;

    state = state.copyWith.sections.at(index).$update((section) {
      switch (section) {
        case final SupersetSectionModel superset:
          final sets = List<Map<String, ISet>>.from(superset.sets);

          final setToAdd = <String, ISet>{};
          for (final (setIndex, exercise) in superset.exercises.indexed) {
            final key = String.fromCharCode(65 + setIndex);
            final value = DefaultSetModel(
              sectionIndex: index,
              setIndex: superset.sets.length,
              setString: key,
              exercise: exercise,
            );
            setToAdd.addAll({key: value});
          }

          return superset.copyWith(sets: sets..add(setToAdd));
        case final DefaultSectionModel defaultSection:
          final sets = List<ISet>.from(defaultSection.sets);
          final setToAdd = DefaultSetModel(
            sectionIndex: index,
            setIndex: defaultSection.sets.length,
            exercise: defaultSection.exercise,
          );

          return defaultSection.copyWith(sets: sets..add(setToAdd));
      }
    });
  }

  void completeDefaultSet(NormalSetForm form, DefaultSetModel currentSet) {
    final section = state.sections[currentSet.sectionIndex];

    switch (section) {
      case final DefaultSectionModel defaultSection:
        state =
            state.copyWith.sections.at(currentSet.sectionIndex).$update((_) {
          return defaultSection.copyWith.sets
              .at(currentSet.setIndex)
              .$update((_) {
            return currentSet.copyWith(
              load: form.model.load,
              reps: form.model.reps,
              units: Units.values[form.model.units!],
            );
          });
        });

      case final SupersetSectionModel supersetSection:
        state =
            state.copyWith.sections.at(currentSet.sectionIndex).$update((_) {
          return supersetSection.copyWith.sets
              .at(currentSet.setIndex)
              .$update((set) {
            set[currentSet.setString] = currentSet.copyWith(
              load: form.model.load,
              reps: form.model.reps,
              units: Units.values[form.model.units!],
            );

            return set;
          });
        });
    }

    state = state.copyWith(subtitle: state.subtitle);
  }

  void removeSection(ISection section) {
    state.sections.remove(section);
    _resetIndexes();
    _updateMuscleGroups();
  }

  void removeDefaultSet(DefaultSetModel set) {
    final section = state.sections[set.sectionIndex];

    switch (section) {
      case final DefaultSectionModel obj:
        obj.sets.remove(set);
      case final SupersetSectionModel obj:
        obj.sets[set.setIndex]
            .removeWhere((key, value) => key == set.setString);

        if (obj.sets[set.setIndex].isEmpty) obj.sets.removeAt(set.setIndex);
    }

    _resetIndexes();
  }

  void _resetIndexes() {
    final sections = List<ISection>.from(state.sections);

    final newSections = sections.mapWithIndex((section, sectionIndex) {
      switch (section) {
        case final DefaultSectionModel defaultSection:
          return defaultSection.copyWith(
            sets: defaultSection.sets.mapWithIndex((set, setIndex) {
              switch (set) {
                case final DefaultSetModel defaultSet:
                  return defaultSet.copyWith(
                    sectionIndex: sectionIndex,
                    setIndex: setIndex,
                  );
              }
            }).toList(),
          );

        case final SupersetSectionModel supersetSection:
          return supersetSection.copyWith(
            sets: supersetSection.sets.mapWithIndex((set, setIndex) {
              return set
                ..updateAll((key, value) {
                  switch (value) {
                    case final DefaultSetModel defaultSet:
                      return defaultSet.copyWith(
                        sectionIndex: sectionIndex,
                        setIndex: setIndex,
                      );
                  }
                });
            }).toList(),
          );
      }
    }).toList();

    state = state.copyWith(sections: newSections);
  }

  void _updateMuscleGroups() {
    final exercises = state.sections.flatMap((section) {
      switch (section) {
        case final DefaultSectionModel defaultSection:
          return [defaultSection.exercise];
        case final SupersetSectionModel supersetSection:
          return supersetSection.exercises;
      }
    }).toList();

    final primaryMuscleGroups = exercises.flatMap((exercise) {
      return exercise.primaryMuscleGroups;
    }).toSet();

    final secondaryMuscleGroups = exercises.flatMap((exercise) {
      return exercise.secondaryMuscleGroups;
    }).toSet()
      ..removeWhere(primaryMuscleGroups.contains);

    state = state.copyWith(
      primaryMuscleGroups: primaryMuscleGroups.toList(),
      secondaryMuscleGroups: secondaryMuscleGroups.toList(),
    );
  }
}
