import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/live_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_workout_controller.g.dart';

@Riverpod(keepAlive: true)
class LiveWorkoutController extends _$LiveWorkoutController {
  @override
  LiveWorkoutModel build() {
    final now = DateTime.now();

    var time = 'Evening';
    if (now.hour < 17) time = 'Afternoon';
    if (now.hour < 11) time = 'Morning';
    if (now.hour < 5) time = 'Night';

    return LiveWorkoutModel(
      subtitle: '$time Workout',
      startTimestamp: now,
      sections: [],
    );
  }

  void addDefaultSection(List<ExerciseModel> exercises) {
    for (final exercise in exercises) {
      final defaultSet = LiveDefaultSetModel(
        exercise: exercise,
        sectionIndex: state.sections.length,
        setIndex: 0,
      );

      final section = LiveDefaultSectionModel(
        templateSet: defaultSet,
        sets: [defaultSet],
      )..generateTitle(exercise);

      state.sections.add(section);
    }

    _updateMuscleGroups();
  }

  void addSupersetSection(List<ExerciseModel> exercises) {
    final set = <String, ILiveSet>{};
    for (final (index, exercise) in exercises.indexed) {
      final key = String.fromCharCode(65 + index);
      final value = LiveDefaultSetModel(
        exercise: exercise,
        sectionIndex: state.sections.length,
        setIndex: 0,
        setString: key,
      );

      set.addAll({key: value});
    }
    final template = Map<String, ILiveSet>.from(set);

    final section = LiveSupersetSectionModel(templateSet: template, sets: [set])
      ..generateTitle(exercises);

    state.sections.add(section);
    _updateMuscleGroups();
  }

  void addSet(ILiveSection<dynamic> section) {
    final index = state.sections.indexOf(section);
    if (index < 0) return;

    switch (state.sections[index]) {
      case final LiveDefaultSectionModel section:
        section.sets
            .add(section.templateSet.copyWith(setIndex: section.sets.length));
      case final LiveSupersetSectionModel section:
        section.sets.add(
          section.templateSet.map((key, value) {
            return MapEntry(key, value.copyWith(setIndex: section.sets.length));
          }),
        );
    }

    // Force UI to update
    state = state.copyWith(subtitle: state.subtitle);
  }

  void completeDefaultSet(NormalSetForm form, LiveDefaultSetModel currentSet) {
    final section = state.sections[currentSet.sectionIndex];

    switch (section) {
      case final LiveDefaultSectionModel obj:
        state.sections[currentSet.sectionIndex] =
            obj.copyWith.sets.at(currentSet.setIndex).$update((set) {
          return currentSet.copyWith(
            isComplete: true,
            load: form.model.load,
            reps: form.model.reps,
            units: Units.values[form.model.units!],
          );
        });

      case final LiveSupersetSectionModel obj:
        state.sections[currentSet.sectionIndex] =
            obj.copyWith.sets.at(currentSet.setIndex).$update((set) {
          set[currentSet.setString] = currentSet.copyWith(
            isComplete: true,
            load: form.model.load,
            reps: form.model.reps,
            units: Units.values[form.model.units!],
          );

          return set;
        });
    }

    // Force UI to update
    state = state.copyWith(subtitle: state.subtitle);
  }

  void removeSection(ILiveSection<dynamic> section) {
    state = state.copyWith(sections: state.sections..remove(section));
    _resetIndexes();
    _updateMuscleGroups();
  }

  void removeDefaultSet(LiveDefaultSetModel setToRemove) {
    final section = state.sections[setToRemove.sectionIndex];

    switch (section) {
      case final LiveDefaultSectionModel obj:
        state = state.copyWith.sections.at(setToRemove.sectionIndex)(
          sets: obj.sets..remove(setToRemove),
        );

      case final LiveSupersetSectionModel obj:
        obj.sets[setToRemove.setIndex]
            .removeWhere((key, value) => key == setToRemove.setString);

        if (obj.sets[setToRemove.setIndex].isEmpty) {
          state = state.copyWith.sections.at(setToRemove.sectionIndex)(
            sets: obj.sets..removeAt(setToRemove.setIndex),
          );
        }
    }

    _resetIndexes();
    _updateMuscleGroups();
  }

  double getTotalVolume(Units units) {
    return state.sections.fold(0, (previousValue, element) {
      return previousValue + element.getVolume(units);
    });
  }

  double getSetsCompleted() {
    return state.sections.fold(0, (previousValue, element) {
      return previousValue + element.getCompletedSets();
    });
  }

  void _resetIndexes() {
    final sections = List<ILiveSection<dynamic>>.from(state.sections);
    final newSections =
        sections.mapWithIndex<ILiveSection<dynamic>>((section, sectionIndex) {
      switch (section) {
        case final LiveDefaultSectionModel obj:
          return obj.copyWith(
            templateSet: obj.templateSet.copyWith(sectionIndex: sectionIndex),
            sets: obj.sets.mapWithIndex((set, setIndex) {
              return set.copyWith(
                sectionIndex: sectionIndex,
                setIndex: setIndex,
              );
            }).toList(),
          );
        case final LiveSupersetSectionModel obj:
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
