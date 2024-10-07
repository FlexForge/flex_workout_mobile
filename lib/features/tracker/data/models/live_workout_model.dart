import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/core/utils/functions.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/history/data/db/historic_workout_entity.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/sections/default_section.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/sections/superset_section.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/sets/default_set_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'live_workout_model.mapper.dart';

@MappableClass()
class LiveWorkoutModel with LiveWorkoutModelMappable {
  LiveWorkoutModel({
    required this.subtitle,
    required this.startTimestamp,
    required this.sections,
    this.newExercises = const <ExerciseModel>[],
    this.primaryMuscleGroups = const <MuscleGroupModel>[],
    this.secondaryMuscleGroups = const <MuscleGroupModel>[],
  });

  final String subtitle;
  final DateTime startTimestamp;

  final List<MuscleGroupModel> primaryMuscleGroups;
  final List<MuscleGroupModel> secondaryMuscleGroups;

  final List<ExerciseModel> newExercises;

  List<ILiveSection<dynamic>> sections;
}

@MappableClass(discriminatorKey: 'organization')
sealed class ILiveSection<T> with ILiveSectionMappable<T> {
  ILiveSection({required this.title, required this.sets});

  String title;
  List<T> sets;

  Widget display();
  List<ExerciseModel> getExercises();

  double getVolume(Units units);
  int getCompletedSets();

  HistoricSectionEntity? toEntity();
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

  void generateTitle(ExerciseModel exercise) => title = exercise.name;

  List<ILiveSet> get completedSets =>
      sets.where((element) => element.isComplete).toList();

  @override
  Widget display() => DefaultSectionView(section: this);

  @override
  List<ExerciseModel> getExercises() => [templateSet.exercise];

  @override
  double getVolume(Units units) {
    return completedSets.fold(0, (previousValue, element) {
      return previousValue + element.getVolume(units);
    });
  }

  @override
  int getCompletedSets() => sets.where((element) => element.isComplete).length;

  @override
  HistoricSectionEntity? toEntity() {
    if (completedSets.isEmpty) return null;

    final defaultSection = HistoricDefaultSectionEntity(title: title)
      ..sets.addAll(completedSets.map((e) => e.toEntity()));
    return HistoricSectionEntity()..defaultSection.target = defaultSection;
  }
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

  List<ILiveSet> get allSets =>
      sets.map((e) => e.values).expand((e) => e).toList();
  List<ILiveSet> get completedSets =>
      allSets.where((element) => element.isComplete).toList();
  List<Map<String, ILiveSet>> get completeSetsMap => sets
      .map((e) => e..removeWhere((key, value) => !value.isComplete))
      .toList();

  @override
  Widget display() => SupersetSectionView(section: this);

  @override
  List<ExerciseModel> getExercises() =>
      templateSet.values.map((value) => value.exercise).toList();

  @override
  double getVolume(Units units) {
    return completedSets.fold(0, (previousValue, element) {
      return previousValue + element.getVolume(units);
    });
  }

  @override
  int getCompletedSets() =>
      allSets.where((element) => element.isComplete).length;

  @override
  HistoricSectionEntity? toEntity() {
    final setsToAdd = completeSetsMap.map(
      (e) => HistoricSupersetWrapperEntity(
        superSetString: e.keys.toList(),
      )..sets.addAll(e.values.map((e) => e.toEntity())),
    );

    final cleanedSets =
        setsToAdd.where((element) => element.sets.isNotEmpty).toList();

    if (cleanedSets.isEmpty) return null;

    final supersetSection = HistoricSupersetSectionEntity(title: title)
      ..supersets.addAll(cleanedSets);
    return HistoricSectionEntity()..supersetSection.target = supersetSection;
  }
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

  double getVolume(Units units);
  Widget display();

  // Indexes
  final int sectionIndex;
  final int setIndex;
  final String setString;

  HistoricSetEntity toEntity();
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

  double getLoadInKgs() => (units == Units.kgs) ? load! : lbsToKgs(load!);
  double getLoadInLbs() => (units == Units.lbs) ? load! : kgsToLbs(load!);

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
  double getVolume(Units units) =>
      (units == Units.kgs) ? getLoadInKgs() * reps! : getLoadInLbs() * reps!;
  @override
  Widget display() => DefaultSetTile(set: this);

  @override
  HistoricSetEntity toEntity() {
    final defaultSet = HistoricDefaultSetEntity(
      reps: reps!,
      load: load!,
      units: units!.index,
    )..exercise.target = exercise.toEntity();
    final setToAdd = HistoricSetEntity()..defaultSet.target = defaultSet;
    return setToAdd;
  }
}

extension Date on DateTime {
  String toReadableDate() => DateFormat.yMMMMd().format(this);

  String toReadableTime() =>
      DateFormat.jm().format(this).toLowerCase().replaceAll(' ', '');
}
