import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_model.dart';
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
      final sections = List<ISection>.from(state.newExercises);
      final sectionToAdd = DefaultSectionModel(sets: [], exercise: exercise);

      state = state.copyWith(sections: sections..add(sectionToAdd));
    }
  }

  void addSupersetSection(List<ExerciseModel> exercises) {
    final sections = List<ISection>.from(state.newExercises);
    final sectionToAdd = SupersetSectionModel(sets: [], exercises: exercises);

    state = state.copyWith(sections: sections..add(sectionToAdd));
  }

  void addDefaultSet(ISection section) {
    final index = state.sections.indexOf(section);
    if (index < 0) return;

    switch (state.sections[index]) {
      case final DefaultSectionModel obj:
        final setToAdd = DefaultSetModel(exercise: obj.exercise);

        obj.sets.add(setToAdd);
      case final SupersetSectionModel obj:
        final setToAdd = <String, ISet>{};
        for (final (index, exercise) in obj.exercises.indexed) {
          final key = String.fromCharCode(65 + index);
          final value = DefaultSetModel(exercise: exercise);
          setToAdd.addAll({key: value});
        }

        obj.sets.add(setToAdd);
    }
  }

  void completeDefaultSet(NormalSetForm form, DefaultSetModel currentSet) {
    throw UnimplementedError();
  }

  void removeSection(ISection section) {
    final sections = List<ISection>.from(state.sections);
    state = state.copyWith(sections: sections..remove(section));
  }

  void removeDefaultSet(DefaultSetModel set) {
    throw UnimplementedError();
  }
}
