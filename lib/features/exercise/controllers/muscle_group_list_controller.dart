import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/exercise/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'muscle_group_list_controller.g.dart';

@riverpod
class MuscleGroupListController extends _$MuscleGroupListController {
  @override
  List<MuscleGroupModel> build() {
    final res = ref.watch(muscleGroupRepositoryProvider).getMuscleGroups();
    return res.fold((l) => throw l, (r) => r);
  }
}
