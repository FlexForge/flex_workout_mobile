import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/current_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart';
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

    return LiveWorkoutModel(subtitle: '$time Workout', startTimestamp: now);
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
  }

  void addSupersetSection(List<ExerciseModel> exercises) {
    final set = <String, ILiveSet>{};
    exercises.mapWithIndex((exercise, index) {
      final key = String.fromCharCode(65 + index);
      final value = LiveDefaultSetModel(
        exercise: exercise,
        sectionIndex: state.sections.length,
        setIndex: 0,
      );

      set.addAll({key: value});
    });

    final section = LiveSupersetSectionModel(templateSet: set, sets: [set])
      ..generateTitle(exercises);

    state.sections.add(section);
  }

  void addSet(int sectionIndex) {
    switch (state.sections[sectionIndex]) {
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
        print(obj.toString());
    }
  }
}
