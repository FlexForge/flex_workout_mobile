import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/core/utils/functions.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/history/data/db/historic_workout_entity.dart';

part 'historic_workout_model.mapper.dart';

@MappableClass()
class HistoricWorkoutModel with HistoricWorkoutModelMappable {
  HistoricWorkoutModel({
    required this.sections,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.notes,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.primaryMuscleGroups,
    required this.secondaryMuscleGroups,
    required this.createdAt,
    required this.updatedAt,
  });

  List<IHistoricSection> sections;

  final int id;
  final String title;
  final String subtitle;
  final String notes;

  final DateTime startTimestamp;
  final DateTime endTimestamp;

  List<MuscleGroupModel> primaryMuscleGroups;
  List<MuscleGroupModel> secondaryMuscleGroups;

  final DateTime createdAt;
  final DateTime updatedAt;

  int get durationInMinutes =>
      startTimestamp.difference(endTimestamp).inMinutes;

  double getVolume({Units units = Units.lbs}) {
    return sections.fold(0, (previousValue, element) {
      return previousValue + element.getVolume(units: units);
    });
  }

  HistoricWorkoutEntity toEntity() => HistoricWorkoutEntity(
        id: id,
        title: title,
        subtitle: subtitle,
        notes: notes,
        startTimestamp: startTimestamp,
        endTimestamp: endTimestamp,
        updatedAt: updatedAt,
        createdAt: createdAt,
      )
        ..primaryMuscleGroups.addAll(primaryMuscleGroups.toEntity())
        ..secondaryMuscleGroups.addAll(secondaryMuscleGroups.toEntity())
        ..sections.addAll(sections.map((e) => e.toEntity()));
}

@MappableClass(discriminatorKey: 'organization')
sealed class IHistoricSection with IHistoricSectionMappable {
  dynamic bestSet();
  double getVolume({Units units = Units.kgs});
  HistoricSectionEntity toEntity();
}

@MappableClass(discriminatorValue: 'default')
class HistoricDefaultSectionModel
    with HistoricDefaultSectionModelMappable
    implements IHistoricSection {
  HistoricDefaultSectionModel({
    required this.id,
    required this.title,
    required this.sets,
  });

  final int id;
  final String title;
  List<IHistoricSet> sets;

  @override
  IHistoricSet bestSet() {
    return sets.fold(sets.first, (previousValue, element) {
      if (element.getVolume() > previousValue.getVolume()) {
        return element;
      }
      return previousValue;
    });
  }

  @override
  double getVolume({Units units = Units.kgs}) {
    return sets.fold(0, (previousValue, element) {
      return previousValue + element.getVolume(units: units);
    });
  }

  @override
  HistoricSectionEntity toEntity() {
    final defaultSection = HistoricDefaultSectionEntity(id: id, title: title)
      ..sets.addAll(sets.map((e) => e.toEntity()));
    return HistoricSectionEntity(id: id)
      ..defaultSection.target = defaultSection;
  }
}

@MappableClass(discriminatorValue: 'superset')
class HistoricSupersetSectionModel
    with HistoricSupersetSectionModelMappable
    implements IHistoricSection {
  HistoricSupersetSectionModel({
    required this.id,
    required this.title,
    required this.sets,
  });

  final int id;
  final String title;
  List<Map<String, IHistoricSet>> sets;

  @override
  Map<String, IHistoricSet> bestSet() {
    final bestSets = <String, IHistoricSet>{};

    for (final set in sets) {
      for (final entry in set.entries) {
        if (!bestSets.containsKey(entry.key)) {
          bestSets[entry.key] = entry.value;
          continue;
        }

        if (entry.value.getVolume() > bestSets[entry.key]!.getVolume()) {
          bestSets[entry.key] = entry.value;
        }
      }
    }

    return bestSets;
  }

  @override
  double getVolume({Units units = Units.kgs}) {
    return sets.fold(0, (previousValue, element) {
      final test = element.values.fold<double>(0, (previousValue, element) {
        return previousValue + element.getVolume(units: units);
      });

      return previousValue + test;
    });
  }

  @override
  HistoricSectionEntity toEntity() {
    final supersetSection = HistoricSupersetSectionEntity(id: id, title: title)
      ..supersets.addAll(
        sets
            .map(
              (e) => HistoricSupersetWrapperEntity(
                id: id,
                superSetString: e.keys.toList(),
              )..sets.addAll(e.values.map((e) => e.toEntity())),
            )
            .toList(),
      );
    return HistoricSectionEntity(id: id)
      ..supersetSection.target = supersetSection;
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class IHistoricSet with IHistoricSetMappable {
  double getVolume({Units units = Units.kgs});
  double getMaxLoad({Units units = Units.kgs});
  double getOneRepMax({Units units = Units.kgs});
  HistoricSetEntity toEntity();
}

@MappableClass(discriminatorValue: 'default')
class HistoricDefaultSetModel
    with HistoricDefaultSetModelMappable
    implements IHistoricSet {
  HistoricDefaultSetModel({
    required this.id,
    required this.reps,
    required this.load,
    required this.units,
    required this.exercise,
    required this.timeOfCompletion,
  });

  final int id;
  final int reps;
  final double load;
  final Units units;

  final ExerciseModel exercise;
  final DateTime timeOfCompletion;

  double get loadInKg => (units == Units.kgs) ? load : lbsToKgs(load);
  double get loadInLbs => (units == Units.lbs) ? load : kgsToLbs(load);

  @override
  double getVolume({Units units = Units.kgs}) =>
      (units == Units.kgs) ? loadInKg * reps : loadInLbs * reps;

  @override
  double getMaxLoad({Units units = Units.kgs}) =>
      (units == Units.kgs) ? loadInKg : loadInLbs;

  @override
  double getOneRepMax({Units units = Units.kgs}) => calculateOneRepMax(
        load: (units == Units.kgs) ? loadInKg : loadInLbs,
        reps: reps,
      );

  @override
  HistoricSetEntity toEntity() {
    final defaultSet = HistoricDefaultSetEntity(
      id: id,
      reps: reps,
      load: load,
      units: units.index,
      timeOfCompletion: timeOfCompletion,
    );
    final defaultSetEntity = HistoricSetEntity()
      ..defaultSet.target = defaultSet
      ..exercise.target = exercise.toEntity();
    return defaultSetEntity;
  }
}
