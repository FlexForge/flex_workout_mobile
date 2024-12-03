import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flex_workout_mobile/features/workout/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_list_controller.g.dart';

@riverpod
class WorkoutListController extends _$WorkoutListController {
  @override
  List<WorkoutModel> build() {
    final res = ref.watch(workoutRepositoryProvider).getWorkouts();
    return res.fold((l) => throw l, (r) => r);
  }

  void addWorkout(WorkoutModel workout) {
    state = [...state, workout];
  }

  void deleteWorkout(WorkoutModel workout) {
    state = state.where((e) => e.id != workout.id).toList();
  }

  void updateWorkout(WorkoutModel workout) {
    final newState = [...state];
    final index = newState.indexWhere((e) => e.id == workout.id);

    if (index == -1) return;

    newState[index] = workout;
    state = newState;
  }
}

extension WorkoutListToMap on List<WorkoutModel> {
  Map<String, List<WorkoutModel>> toMap() {
    final separatedList = <String, List<WorkoutModel>>{};

    for (final workout in this) {
      final firstChar = workout.title[0].toUpperCase();
      final key =
          (firstChar.isNotEmpty && RegExp('^[a-zA-Z]').hasMatch(firstChar))
              ? firstChar
              : '#';

      if (separatedList.containsKey(key)) {
        separatedList[key]!.add(workout);
      } else {
        separatedList[key] = [workout];
      }
    }

    // Sort each subgroup
    for (final key in separatedList.keys) {
      separatedList[key]!.sort((a, b) => a.title.compareTo(b.title));
    }

    // Sort the keys
    final keys = separatedList.keys.toList()..sort();

    final sortedSeparatedList = <String, List<WorkoutModel>>{};
    for (final key in keys) {
      sortedSeparatedList[key] = separatedList[key]!;
    }

    return sortedSeparatedList;
  }
}
