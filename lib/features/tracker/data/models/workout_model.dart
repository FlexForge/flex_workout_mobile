import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';

part 'workout_model.mapper.dart';

@MappableClass()
class WorkoutModel with WorkoutModelMappable {
  WorkoutModel({
    required this.sections,
    required this.subtitle,
    required this.startTimestamp,
    this.newExercises = const <ExerciseModel>[],
    this.primaryMuscleGroups = const <MuscleGroupModel>[],
    this.secondaryMuscleGroups = const <MuscleGroupModel>[],
  });

  List<ISection> sections;

  final String subtitle;
  final DateTime startTimestamp;

  final List<MuscleGroupModel> primaryMuscleGroups;
  final List<MuscleGroupModel> secondaryMuscleGroups;

  final List<ExerciseModel> newExercises;

  int get durationInMinutes =>
      startTimestamp.difference(DateTime.now()).inMinutes;

  double getVolume({Units units = Units.kgs}) {
    return sections.fold(0, (previousValue, element) {
      return previousValue + element.getVolume(units: units);
    });
  }
}

@MappableClass(discriminatorKey: 'organization')
sealed class ISection with ISectionMappable {
  dynamic bestSet();
  double getVolume({Units units = Units.kgs});
  // HistoricSectionEntity toEntity();
}

@MappableClass(discriminatorValue: 'default')
class DefaultSectionModel with DefaultSectionModelMappable implements ISection {
  DefaultSectionModel({
    required this.sets,
    required this.exercise,
  });

  List<ISet> sets;
  ExerciseModel exercise;

  String get title => exercise.name;

  @override
  ISet? bestSet() {
    return null;
  }

  @override
  double getVolume({Units units = Units.kgs}) {
    return 0;
  }
}

@MappableClass(discriminatorValue: 'superset')
class SupersetSectionModel
    with SupersetSectionModelMappable
    implements ISection {
  SupersetSectionModel({required this.sets, required this.exercises});

  List<Map<String, ISet>> sets;
  List<ExerciseModel> exercises;

  @override
  ISet? bestSet() {
    return null;
  }

  @override
  double getVolume({Units units = Units.kgs}) {
    return 0;
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class ISet with ISetMappable {
  double getVolume({Units units = Units.kgs});
  // HistoricSetEntity toEntity();
}

@MappableClass(discriminatorValue: 'default')
class DefaultSetModel with DefaultSetModelMappable implements ISet {
  DefaultSetModel({
    required this.exercise,
    this.reps,
    this.load,
    this.units,
  });

  final int? reps;
  final double? load;
  final Units? units;

  final ExerciseModel exercise;

  @override
  double getVolume({Units units = Units.kgs}) => 0;
}
