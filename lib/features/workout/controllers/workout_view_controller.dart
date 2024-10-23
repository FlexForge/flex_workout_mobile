import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:flex_workout_mobile/features/workout/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_view_controller.g.dart';

@riverpod
class WorkoutViewController extends _$WorkoutViewController {
  @override
  WorkoutModel build(String id) {
    final workoutId = int.tryParse(id);
    if (workoutId == null) throw const Failure.badRequest();

    final res = ref.watch(workoutRepositoryProvider).getWorkoutById(workoutId);

    return res.fold((l) => throw l, (r) => r);
  }
}
