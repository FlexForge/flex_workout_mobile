import 'dart:collection';
import 'dart:math';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/workout/data/db/workout_entity.dart';
import 'package:flex_workout_mobile/features/workout/ui/containers/sections/default_section.dart';
import 'package:flex_workout_mobile/features/workout/ui/containers/sections/superset_section.dart';
import 'package:flex_workout_mobile/features/workout/ui/containers/sets/default_set_tile.dart';
import 'package:flutter/material.dart';

part 'workout_model.mapper.dart';

@MappableClass()
class WorkoutModel with WorkoutModelMappable {
  WorkoutModel({
    required this.sections,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.primaryMuscleGroups,
    required this.secondaryMuscleGroups,
    required this.createdAt,
    required this.updatedAt,
  });

  List<IWorkoutSection<dynamic>> sections;

  final int id;
  final String title;
  final String subtitle;
  final String description;

  List<MuscleGroupModel> primaryMuscleGroups;
  List<MuscleGroupModel> secondaryMuscleGroups;

  final DateTime updatedAt;
  final DateTime createdAt;

  WorkoutEntity toEntity() {
    return WorkoutEntity(
      title: title,
      subtitle: subtitle,
      description: description,
      updatedAt: updatedAt,
      createdAt: createdAt,
    )
      ..primaryMuscleGroups.addAll(primaryMuscleGroups.toEntity())
      ..secondaryMuscleGroups.addAll(secondaryMuscleGroups.toEntity())
      ..sections.addAll(sections.map((e) => e.toEntity()));
  }
}

@MappableClass(discriminatorKey: 'organization')
sealed class IWorkoutSection<T> with IWorkoutSectionMappable<T> {
  IWorkoutSection({
    required this.title,
    required this.sets,
  });

  String title;
  List<T> sets;

  Widget display();
  List<ExerciseModel> getExercises();
  dynamic getTotalSets();

  int get minReps;
  int? get maxReps;

  WorkoutSectionEntity toEntity();
}

@MappableClass(discriminatorValue: 'default')
class WorkoutDefaultSectionModel
    with WorkoutDefaultSectionModelMappable
    implements IWorkoutSection<IWorkoutSet> {
  WorkoutDefaultSectionModel({
    required this.id,
    required this.sets,
    required this.templateSet,
    this.title = '',
  });

  final int id;

  @override
  String title;

  final IWorkoutSet templateSet;

  @override
  List<IWorkoutSet> sets;

  void generateTitle(ExerciseModel exercise) => title = exercise.name;

  @override
  Widget display() => DefaultSectionView(section: this);

  @override
  List<ExerciseModel> getExercises() => [templateSet.exercise];

  @override
  int getTotalSets() => sets.length;

  @override
  int get minReps => sets.fold(99, (prev, e) {
        switch (e) {
          case final WorkoutDefaultSetModel defaultSet:
            return min(prev, defaultSet.minReps);
        }
      });

  @override
  int? get maxReps {
    final maxReps = sets.fold(0, (prev, e) {
      switch (e) {
        case final WorkoutDefaultSetModel defaultSet:
          return max(max(prev, defaultSet.minReps), defaultSet.maxReps ?? prev);
      }
    });

    if (maxReps <= minReps) return null;
    return maxReps;
  }

  @override
  WorkoutSectionEntity toEntity() {
    final defaultSection = DefaultSectionEntity(id: id, title: title)
      ..sets.addAll(sets.map((e) => e.toEntity()));
    return WorkoutSectionEntity(id: id)..defaultSection.target = defaultSection;
  }
}

@MappableClass(discriminatorValue: 'superset')
class WorkoutSupersetSectionModel
    with WorkoutSupersetSectionModelMappable
    implements IWorkoutSection<Map<String, IWorkoutSet>> {
  WorkoutSupersetSectionModel({
    required this.id,
    required this.sets,
    required this.templateSet,
    this.title = '',
  });

  final int id;

  @override
  String title;

  final Map<String, IWorkoutSet> templateSet;

  @override
  List<Map<String, IWorkoutSet>> sets;

  void generateTitle(List<ExerciseModel> exercises) =>
      title = exercises.map((exercise) => exercise.name).toList().join(' and ');

  @override
  Widget display() => SupersetSectionView(section: this);

  @override
  List<ExerciseModel> getExercises() =>
      templateSet.values.map((value) => value.exercise).toList();

  @override
  Map<String, int> getTotalSets() {
    final totalSets = <String, int>{};

    for (final set in sets) {
      for (final entry in set.entries) {
        if (totalSets.containsKey(entry.key)) {
          totalSets[entry.key] = totalSets[entry.key]! + 1;
          continue;
        }

        totalSets.addAll({entry.key: 1});
      }
    }

    /// TODO: sorted and take first and last - maybe delete this later
    final sortedTotalSets = SplayTreeMap<String, int>.from(
      totalSets,
      (k1, k2) => totalSets[k1]!.compareTo(totalSets[k2]!),
    );

    if (sortedTotalSets.entries.first.value ==
        sortedTotalSets.entries.last.value) {
      return {
        sortedTotalSets.entries.first.key: sortedTotalSets.entries.first.value,
      };
    }
    return {
      sortedTotalSets.entries.first.key: sortedTotalSets.entries.first.value,
      sortedTotalSets.entries.last.key: sortedTotalSets.entries.last.value,
    };

    // TODO: all total sets - maybe delete this later
    // return totalSets;
  }

  @override
  int get minReps => sets.fold(99, (prev, e) {
        final minReps = e.values.fold<int>(99, (prev, e) {
          switch (e) {
            case final WorkoutDefaultSetModel defaultSet:
              return min(prev, defaultSet.minReps);
          }
        });
        return min(prev, minReps);
      });

  @override
  int? get maxReps => sets.fold(0, (prev, e) {
        final maxReps = e.values.fold<int>(0, (prev, e) {
          switch (e) {
            case final WorkoutDefaultSetModel defaultSet:
              return max(prev, defaultSet.maxReps ?? prev);
          }
        });
        return max(prev!, maxReps);
      });

  @override
  WorkoutSectionEntity toEntity() {
    final supersetSection = SupersetSectionEntity(id: id, title: title)
      ..supersets.addAll(
        sets
            .map(
              (e) => SupersetWrapperEntity(
                id: id,
                supersetString: e.keys.toList(),
              )..sets.addAll(e.values.map((e) => e.toEntity())),
            )
            .toList(),
      );
    return WorkoutSectionEntity(id: id)
      ..supersetSection.target = supersetSection;
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class IWorkoutSet with IWorkoutSetMappable {
  IWorkoutSet({
    required this.exercise,
    required this.sectionIndex,
    required this.setIndex,
    this.setString = '',
  });

  final ExerciseModel exercise;

  Widget display();

  // Indexes
  final int? sectionIndex;
  final int? setIndex;
  final String? setString;

  SetEntity toEntity();
}

@MappableClass(discriminatorValue: 'default')
class WorkoutDefaultSetModel
    with WorkoutDefaultSetModelMappable
    implements IWorkoutSet {
  WorkoutDefaultSetModel({
    required this.id,
    required this.exercise,
    required this.minReps,
    this.maxReps,
    this.sectionIndex,
    this.setIndex,
    this.setString = '',
  });

  final int id;
  final int minReps;
  final int? maxReps;

  @override
  final ExerciseModel exercise;
  @override
  final int? sectionIndex;
  @override
  final int? setIndex;
  @override
  final String? setString;

  @override
  Widget display() => DefaultSetTile(set: this);

  @override
  SetEntity toEntity() {
    final defaultSet = DefaultSetEntity(
      id: id,
      minReps: minReps,
      maxReps: maxReps,
    )..exercise.target = exercise.toEntity();

    return SetEntity()..defaultSet.target = defaultSet;
  }
}
