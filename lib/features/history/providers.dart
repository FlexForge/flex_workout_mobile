import 'package:flex_workout_mobile/core/config/providers.dart';
import 'package:flex_workout_mobile/features/history/data/repositories/historic_workout_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
HistoricWorkoutRepository historicWorkoutRepository(
  HistoricWorkoutRepositoryRef ref,
) {
  return HistoricWorkoutRepository(store: ref.watch(objectBoxStoreProvider));
}
