import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/features/workout/data/repositories/workout_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
WorkoutRepository workoutRepository(WorkoutRepositoryRef ref) {
  return WorkoutRepository(store: ref.watch(objectBoxStoreProvider));
}
