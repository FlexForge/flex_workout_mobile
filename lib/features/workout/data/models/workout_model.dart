import 'dart:collection';
import 'dart:math';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/workout/data/db/workout_entity.dart';

part 'workout_model.mapper.dart';

@MappableClass()
class WorkoutModel with WorkoutModelMappable {
  WorkoutModel({
    required this.sections,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  List<IWorkoutSection> sections;

  final int id;
  final String title;
  final String subtitle;
  final String description;

  final DateTime updatedAt;
  final DateTime createdAt;

  WorkoutEntity toEntity() {
    return WorkoutEntity(
      title: title,
      subtitle: subtitle,
      description: description,
      updatedAt: updatedAt,
      createdAt: createdAt,
    )..sections.addAll(sections.map((e) => e.toEntity()));
  }
}

@MappableClass(discriminatorKey: 'organization')
sealed class IWorkoutSection with IWorkoutSectionMappable {
  WorkoutSectionEntity toEntity();
}

@MappableClass(discriminatorValue: 'default')
class DefaultWorkoutSectionModel
    with DefaultWorkoutSectionModelMappable
    implements IWorkoutSection {
  DefaultWorkoutSectionModel({
    required this.id,
    required this.title,
    required this.sets,
  });

  final int id;
  final String title;
  List<IWorkoutSet> sets;

  int get totalSets => sets.length;

  int get minReps => sets.fold(99, (prev, e) {
        switch (e) {
          case final DefaultWorkoutSetModel defaultSet:
            return min(prev, defaultSet.minReps);
        }
      });

  int? get maxReps {
    final maxReps = sets.fold(0, (prev, e) {
      switch (e) {
        case final DefaultWorkoutSetModel defaultSet:
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
class SupersetWorkoutSectionModel
    with SupersetWorkoutSectionModelMappable
    implements IWorkoutSection {
  SupersetWorkoutSectionModel({
    required this.id,
    required this.title,
    required this.sets,
  });

  final int id;
  final String title;
  List<Map<String, IWorkoutSet>> sets;

  Map<String, int> getTotalSets() {
    Map<String, int> totalSets = {};

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
    Map<String, int> sortedTotalSets = SplayTreeMap.from(
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
      sortedTotalSets.entries.last.key: sortedTotalSets.entries.last.value
    };

    /// TODO: all total sets - maybe delete this later
    // return totalSets;
  }

  int get minReps => sets.fold(99, (prev, e) {
        final minReps = e.values.fold<int>(99, (prev, e) {
          switch (e) {
            case final DefaultWorkoutSetModel defaultSet:
              return min(prev, defaultSet.minReps);
          }
        });
        return min(prev, minReps);
      });

  int? get maxReps => sets.fold(0, (prev, e) {
        final maxReps = e.values.fold<int>(0, (prev, e) {
          switch (e) {
            case final DefaultWorkoutSetModel defaultSet:
              return max(prev, defaultSet.maxReps ?? prev);
          }
        });
        return max(prev!, maxReps);
      });

  @override
  WorkoutSectionEntity toEntity() {
    final supersetSection = SupersetSectionEntity(id: id, title: title)
      ..supersets.addAll(sets
          .map(
            (e) => SupersetWrapperEntity(
              id: id,
              supersetString: e.keys.toList(),
            )..sets.addAll(e.values.map((e) => e.toEntity())),
          )
          .toList());
    return WorkoutSectionEntity(id: id)
      ..supersetSection.target = supersetSection;
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class IWorkoutSet with IWorkoutSetMappable {
  SetEntity toEntity();
}

@MappableClass(discriminatorValue: 'default')
class DefaultWorkoutSetModel
    with DefaultWorkoutSetModelMappable
    implements IWorkoutSet {
  DefaultWorkoutSetModel({
    required this.id,
    required this.minReps,
    this.maxReps,
    this.muscleGroup,
    this.movementPattern,
    this.exercise,
  });

  final int id;
  final int minReps;
  final int? maxReps;

  final MuscleGroupModel? muscleGroup;
  final MovementPattern? movementPattern;
  final ExerciseModel? exercise;

  @override
  SetEntity toEntity() {
    final defaultSet = DefaultSetEntity(
      id: id,
      minReps: minReps,
      maxReps: maxReps,
    )..exercise.target = exercise?.toEntity();

    return SetEntity()..defaultSet.target = defaultSet;
  }
}
