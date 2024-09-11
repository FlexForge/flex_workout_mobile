import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/current_workout_model.dart';
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
    if (now.hour > 17) time = 'Afternoon';
    if (now.hour > 11) time = 'Morning';

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

    // Force UI to update
    state = state.copyWith(subtitle: state.subtitle);
  }

  void addSupersetSection(List<ExerciseModel> exercises) {
    final set = <String, ILiveSet>{};
    for (final (index, exercise) in exercises.indexed) {
      final key = String.fromCharCode(65 + index);
      final value = LiveDefaultSetModel(
        exercise: exercise,
        sectionIndex: state.sections.length,
        setIndex: 0,
      );

      set.addAll({key: value});
    }

    final section = LiveSupersetSectionModel(templateSet: set, sets: [set])
      ..generateTitle(exercises);

    state.sections.add(section);
    // Force UI to update
    state = state.copyWith(subtitle: state.subtitle);
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
        obj.copyWith.sets.at(currentSet.setIndex).$update((set) {
          return currentSet.copyWith(
            isComplete: true,
            load: form.model.load,
            reps: form.model.reps,
            units: Units.values[form.model.units!],
          );
        });

      case final LiveSupersetSectionModel obj:
        final mapEntry =
            obj.getSetFromExercise(currentSet.exercise, currentSet.setIndex);

        obj.sets[currentSet.setIndex][mapEntry.key]!.copyWith.$update((set) {
          return currentSet.copyWith(
            isComplete: true,
            load: form.model.load,
            reps: form.model.reps,
            units: Units.values[form.model.units!],
          );
        });
    }
  }

  void removeSection(int sectionIndex) {
    state.sections.removeAt(sectionIndex);
  }
}
