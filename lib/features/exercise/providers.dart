import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/features/exercise/data/repositories/exercise_repository.dart';
import 'package:flex_workout_mobile/features/exercise/data/repositories/muscle_group_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
ExerciseRepository exerciseRepository(ExerciseRepositoryRef ref) {
  return ExerciseRepository(store: ref.watch(objectBoxStoreProvider));
}

@riverpod
MuscleGroupRepository muscleGroupRepository(MuscleGroupRepositoryRef ref) {
  return MuscleGroupRepository(store: ref.watch(objectBoxStoreProvider));
}
