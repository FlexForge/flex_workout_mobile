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
