import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_workout_model.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class CurrentWorkout with _$CurrentWorkout {
  const factory CurrentWorkout({
    required String title,
    required String subtitle,
    required DateTime startTimestamp,
    required List<CurrentWorkoutSection> sections,
    @Default([]) List<MuscleGroupModel> primaryMuscleGroups,
    @Default([]) List<MuscleGroupModel> secondaryMuscleGroups,
    String? notes,
  }) = _CurrentWorkout;
}

@Freezed(makeCollectionsUnmodifiable: false)
class CurrentWorkoutSection with _$CurrentWorkoutSection {
  const factory CurrentWorkoutSection({
    required String title,
    required CurrentWorkoutOrganizer templateOrganizer,
    required List<CurrentWorkoutOrganizer> organizers,
  }) = _CurrentWorkoutSection;
}

extension ConvertCurrentWorkoutSection on CurrentWorkoutSection {
  WorkoutSection toEntity() => WorkoutSection(
        title: title,
      )..organizers.addAll(organizers.map((e) => e.toEntity()).toList());
}

@Freezed(makeCollectionsUnmodifiable: false)
class CurrentWorkoutOrganizer with _$CurrentWorkoutOrganizer {
  const factory CurrentWorkoutOrganizer({
    required SetOrganizationEnum organization,
    required int setNumber,
    required List<CurrentWorkoutSetType> superSet,
    CurrentWorkoutSetType? defaultSet,
  }) = _CurrentWorkoutOrganizer;
}

extension ConvertCurrentWorkoutOrganizer on CurrentWorkoutOrganizer {
  SetOrganizer toEntity() => SetOrganizer(setNumber: setNumber)
    ..defaultSet.target = organization == SetOrganizationEnum.defaultSet
        ? defaultSet?.toEntity()
        : null
    ..superSet.addAll(
      superSet.where((e) => e.toEntity() != null).map((e) => e.toEntity()!),
    );
}

@freezed
class CurrentWorkoutSetType with _$CurrentWorkoutSetType {
  const factory CurrentWorkoutSetType({
    // Index Information
    required ExerciseModel exercise,
    required SetTypeEnum type,
    required int sectionIndex,
    required int organizerIndex,
    @Default(false) bool isComplete,
    int? setIndex,
    String? setLetter,
    CurrentWorkoutNormalSet? normalSet,
  }) = _CurrentWorkoutSetType;
}

extension ConvertCurrentWorkoutSetType on CurrentWorkoutSetType {
  SetType? toEntity() => isComplete
      ? (SetType(setLetter: setLetter)
        ..exercise.target = exercise.toEntity()
        ..normalSet.target =
            type == SetTypeEnum.normalSet ? normalSet?.toEntity() : null)
      : null;
}

@freezed
class CurrentWorkoutNormalSet with _$CurrentWorkoutNormalSet {
  const factory CurrentWorkoutNormalSet({
    required int reps,
    required double load,
    required Units units,
  }) = _CurrentWorkoutNormalSet;
}

extension ConvertCurrentWorkoutNormalSet on CurrentWorkoutNormalSet {
  NormalSet toEntity() => NormalSet(
        reps: reps,
        load: load,
        units: units,
      );
}
