import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
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
        ..secondaryMuscleGroups.addAll(secondaryMuscleGroups.toEntity());
}

@MappableClass(discriminatorKey: 'organization')
sealed class IHistoricSection with IHistoricSectionMappable {
  // HistoricSectionEntity toEntity();
}

@MappableClass(discriminatorValue: 'default')
class HistoricDefaultSectionModel
    with HistoricDefaultSectionModelMappable
    implements IHistoricSection {
  HistoricDefaultSectionModel({
    required this.title,
    required this.sets,
  });

  final String title;
  List<IHistoricSet> sets;
}

@MappableClass(discriminatorValue: 'superset')
class HistoricSupersetSectionModel
    with HistoricSupersetSectionModelMappable
    implements IHistoricSection {
  HistoricSupersetSectionModel({
    required this.title,
    required this.sets,
  });

  final String title;
  List<Map<String, IHistoricSet>> sets;
}

@MappableClass(discriminatorKey: 'type')
sealed class IHistoricSet with IHistoricSetMappable {}

@MappableClass(discriminatorValue: 'superset')
class HistoricDefaultSetModel
    with HistoricDefaultSetModelMappable
    implements IHistoricSet {
  HistoricDefaultSetModel({
    required this.reps,
    required this.load,
    required this.units,
    required this.exercise,
  });

  final int reps;
  final int load;
  final Units units;

  final ExerciseModel exercise;
}
