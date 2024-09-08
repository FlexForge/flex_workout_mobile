import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_workout_model.freezed.dart';

@freezed
class CurrentWorkout with _$CurrentWorkout {
  const factory CurrentWorkout({
    required String title,
    required String subtitle,
    required DateTime startTimestamp,
    @Default([]) List<MuscleGroupModel> primaryMuscleGroups,
    @Default([]) List<MuscleGroupModel> secondaryMuscleGroups,
    @Default([]) List<CurrentWorkoutSection> sections,
    String? notes,
  }) = _CurrentWorkout;
}

@freezed
class CurrentWorkoutSection with _$CurrentWorkoutSection {
  const factory CurrentWorkoutSection({
    required String title,
    required CurrentWorkoutOrganizer templateOrganizer,
    @Default([]) List<CurrentWorkoutOrganizer> organizers,
  }) = _CurrentWorkoutSection;
}

@freezed
class CurrentWorkoutOrganizer with _$CurrentWorkoutOrganizer {
  const factory CurrentWorkoutOrganizer({
    required SetOrganizationEnum organization,
    required int setNumber,
    CurrentWorkoutSetType? defaultSet,
    @Default([]) List<CurrentWorkoutSetType> superSet,
  }) = _CurrentWorkoutOrganizer;
}

@freezed
class CurrentWorkoutSetType with _$CurrentWorkoutSetType {
  const factory CurrentWorkoutSetType({
    required ExerciseModel exercise,
    required SetTypeEnum type,
    String? setLetter,
    CurrentWorkoutNormalSet? normalSet,
  }) = _CurrentWorkoutSetType;
}

@freezed
class CurrentWorkoutNormalSet with _$CurrentWorkoutNormalSet {
  const factory CurrentWorkoutNormalSet() = _CurrentWorkoutNormalSet;
}
