import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
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

extension ConvertCurrentWorkoutSection on CurrentWorkoutSection {
  WorkoutSection toEntity() => WorkoutSection(
        title: title,
      )..organizers.addAll(organizers.map((e) => e.toEntity()).toList());
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

extension ConvertCurrentWorkoutOrganizer on CurrentWorkoutOrganizer {
  SetOrganizer toEntity() => SetOrganizer()
    ..defaultSet.target = organization == SetOrganizationEnum.defaultSet
        ? defaultSet?.toEntity()
        : null
    ..superSet.addAll(superSet.map((e) => e.toEntity()).toList());
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

extension ConvertCurrentWorkoutSetType on CurrentWorkoutSetType {
  SetType toEntity() => SetType()
    ..exercise.target = exercise.toEntity()
    ..normalSet.target =
        type == SetTypeEnum.normalSet ? normalSet?.toEntity() : null;
}

@freezed
class CurrentWorkoutNormalSet with _$CurrentWorkoutNormalSet {
  const factory CurrentWorkoutNormalSet() = _CurrentWorkoutNormalSet;
}

extension ConvertCurrentWorkoutNormalSet on CurrentWorkoutNormalSet {
  NormalSet toEntity() => NormalSet();
}
