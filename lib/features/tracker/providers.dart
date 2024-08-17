import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/features/tracker/data/repositories/tracked_workout_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
TrackedWorkoutRepository trackedWorkoutRepository(
  TrackedWorkoutRepositoryRef ref,
) {
  return TrackedWorkoutRepository(store: ref.watch(objectBoxStoreProvider));
}
