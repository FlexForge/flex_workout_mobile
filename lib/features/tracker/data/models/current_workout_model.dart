import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/sections/default_section.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/sections/superset_section.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/sets/default_set_tile.dart';
import 'package:flutter/material.dart';
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
    required this.subtitle,
    required this.startTimestamp,
    required this.sections,
    this.primaryMuscleGroups = const <MuscleGroupModel>[],
    this.secondaryMuscleGroups = const <MuscleGroupModel>[],
  });

  final String subtitle;
  final DateTime startTimestamp;

  final List<MuscleGroupModel> primaryMuscleGroups;
  final List<MuscleGroupModel> secondaryMuscleGroups;

  List<ILiveSection<dynamic>> sections;
}

@MappableClass(discriminatorKey: 'organization')
sealed class ILiveSection<T> with ILiveSectionMappable<T> {
  ILiveSection({required this.title, required this.sets});

  String title;
  List<T> sets;

  Widget display();
  List<ExerciseModel> getExercises();
}

@MappableClass(discriminatorValue: 'default')
class LiveDefaultSectionModel
    with LiveDefaultSectionModelMappable
    implements ILiveSection<ILiveSet> {
  LiveDefaultSectionModel({
    required this.sets,
    required this.templateSet,
    this.title = '',
  });

  @override
  String title;

  final ILiveSet templateSet;
  @override
  List<ILiveSet> sets;

  void generateTitle(ExerciseModel exercise) {
    title = exercise.name;
  }

  @override
  Widget display() => DefaultSectionView(section: this);

  @override
  List<ExerciseModel> getExercises() => [templateSet.exercise];
}

@MappableClass(discriminatorValue: 'superset')
class LiveSupersetSectionModel
    with LiveSupersetSectionModelMappable
    implements ILiveSection<Map<String, ILiveSet>> {
  LiveSupersetSectionModel({
    required this.sets,
    required this.templateSet,
    this.title = '',
  });

  @override
  String title;

  final Map<String, ILiveSet> templateSet;
  @override
  List<Map<String, ILiveSet>> sets;

  void generateTitle(List<ExerciseModel> exercises) {
    title = exercises.first.name;
  }

  MapEntry<String, ILiveSet> getSetFromExercise(
    ExerciseModel exercise,
    int setIndex,
  ) {
    return sets[setIndex].entries.firstWhere(
          (entry) => entry.value.exercise.id == exercise.id,
        );
  }

  @override
  Widget display() => SupersetSectionView(section: this);

  @override
  List<ExerciseModel> getExercises() =>
      templateSet.values.map((value) => value.exercise).toList();
}

@MappableClass(discriminatorKey: 'type')
sealed class ILiveSet with ILiveSetMappable {
  ILiveSet({
    required this.exercise,
    required this.sectionIndex,
    required this.setIndex,
    this.isComplete = false,
    this.setString = '',
  });
  final bool isComplete;
  final ExerciseModel exercise;

  Widget display();

  // Indexes
  final int sectionIndex;
  final int setIndex;
  final String setString;
}

@MappableClass(discriminatorValue: 'default_set')
class LiveDefaultSetModel with LiveDefaultSetModelMappable implements ILiveSet {
  LiveDefaultSetModel({
    required this.exercise,
    required this.sectionIndex,
    required this.setIndex,
    this.setString = '',
    this.isComplete = false,
    this.reps,
    this.load,
    this.units,
  });

  final int? reps;
  final double? load;
  final Units? units;

  @override
  final ExerciseModel exercise;
  @override
  final bool isComplete;
  @override
  final int sectionIndex;
  @override
  final int setIndex;
  @override
  final String setString;

  @override
  Widget display() => DefaultSetTile(set: this);
}
