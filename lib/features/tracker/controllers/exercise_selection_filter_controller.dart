import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_selection_filter_controller.g.dart';

@riverpod
class MuscleGroupFilterController extends _$MuscleGroupFilterController {
  @override
  List<MuscleGroupModel> build() {
    return [];
  }

  void handle(MuscleGroupModel muscleGroup) {
    if (state.contains(muscleGroup)) {
      state = state.where((entry) => entry != muscleGroup).toList();
    } else {
      state = [...state, muscleGroup];
    }
  }

  void clear() {
    state = [];
  }
}

@riverpod
class EquipmentFilterController extends _$EquipmentFilterController {
  @override
  List<Equipment> build() {
    return [];
  }

  void handle(Equipment equipment) {
    if (state.contains(equipment)) {
      state = state.where((entry) => entry != equipment).toList();
    } else {
      state = [...state, equipment];
    }
  }

  void clear() {
    state = [];
  }
}

@riverpod
class MovementPatternFilterController
    extends _$MovementPatternFilterController {
  @override
  List<MovementPattern> build() {
    return [];
  }

  void handle(MovementPattern pattern) {
    if (state.contains(pattern)) {
      state = state.where((entry) => entry != pattern).toList();
    } else {
      state = [...state, pattern];
    }
  }

  void clear() {
    state = [];
  }
}
