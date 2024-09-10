import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_workout_model.freezed.dart';
part 'current_workout_model.mapper.dart';

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

@MappableClass()
class LiveWorkoutModel with LiveWorkoutModelMappable {
  LiveWorkoutModel({
    required this.title,
    required this.subtitle,
    required this.startTimestamp,
    this.primaryMuscleGroups = const <MuscleGroupModel>[],
    this.secondaryMuscleGroups = const <MuscleGroupModel>[],
    this.sections = const <LiveSectionModel>[],
  });

  final String title;
  String? notes;

  final String subtitle;
  final DateTime startTimestamp;

  final List<MuscleGroupModel> primaryMuscleGroups;
  final List<MuscleGroupModel> secondaryMuscleGroups;

  final List<LiveSectionModel> sections;
}

@MappableClass()
class LiveSectionModel with LiveSectionModelMappable {
  LiveSectionModel({
    required this.title,
    required this.templateOrganizer,
    required this.organizers,
  });

  final String title;
  final ILiveOrganizer templateOrganizer;
  final List<ILiveOrganizer> organizers;

  String get generateTitle => 'Test';
}

@MappableClass(discriminatorKey: 'organization')
sealed class ILiveOrganizer with ILiveOrganizerMappable {
  ILiveOrganizer({
    required this.setNumber,
  });
  final String setNumber;
}

@MappableClass(discriminatorValue: 'default')
class LiveDefaultOrganizerModel
    with LiveDefaultOrganizerModelMappable
    implements ILiveOrganizer {
  LiveDefaultOrganizerModel({required this.setNumber, required this.set});

  @override
  final String setNumber;

  final ILiveSet set;
}

@MappableClass(discriminatorValue: 'superset')
class LiveSupersetOrganizerModel
    with LiveSupersetOrganizerModelMappable
    implements ILiveOrganizer {
  LiveSupersetOrganizerModel({
    required this.setNumber,
    required this.sets,
  });

  @override
  final String setNumber;

  final Map<String, ILiveSet> sets;
}

@MappableClass(discriminatorKey: 'type')
sealed class ILiveSet with ILiveSetMappable {
  ILiveSet({
    required this.isComplete,
    required this.exercise,
    required this.sectionIndex,
    required this.organizerIndex,
  });
  final bool isComplete;
  final ExerciseModel exercise;

  // Index
  final int sectionIndex;
  final int organizerIndex;
}

@MappableClass(discriminatorValue: 'default_set')
class LiveDefaultSetModel with LiveDefaultSetModelMappable implements ILiveSet {
  LiveDefaultSetModel({
    required this.reps,
    required this.load,
    required this.units,
    required this.exercise,
    required this.isComplete,
    required this.sectionIndex,
    required this.organizerIndex,
  });

  final int reps;
  final double load;
  final Units units;

  @override
  final ExerciseModel exercise;
  @override
  final bool isComplete;
  @override
  final int sectionIndex;
  @override
  final int organizerIndex;
}
