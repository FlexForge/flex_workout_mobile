import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/core/utils/functions.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/history/data/db/historic_workout_entity.dart';

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
      DateTime.now().difference(startTimestamp).inMinutes;

  double getVolume({Units units = Units.kgs}) {
    return sections.fold(0, (previousValue, element) {
      return previousValue + element.getVolume(units: units);
    });
  }

  int getTotalSets() {
    return sections.fold(0, (previousValue, element) {
      return previousValue + element.getCompletedSets();
    });
  }
}

@MappableClass(discriminatorKey: 'organization')
sealed class ISection with ISectionMappable {
  dynamic bestSet();
  double getVolume({Units units = Units.kgs});
  int getCompletedSets();
  HistoricSectionEntity? toEntity();
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
  List<ISet> get completedSets => sets.where((set) => set.isComplete).toList();

  @override
  ISet? bestSet() {
    return null;
  }

  @override
  double getVolume({Units units = Units.kgs}) {
    return completedSets.fold(0, (previousValue, element) {
      return previousValue + element.getVolume(units: units);
    });
  }

  @override
  int getCompletedSets() => completedSets.length;

  @override
  HistoricSectionEntity? toEntity() {
    if (completedSets.isEmpty) return null;

    final defaultSection = HistoricDefaultSectionEntity(title: title)
      ..sets.addAll(completedSets.map((set) => set.toEntity()!));
    return HistoricSectionEntity()..defaultSection.target = defaultSection;
  }
}

@MappableClass(discriminatorValue: 'superset')
class SupersetSectionModel
    with SupersetSectionModelMappable
    implements ISection {
  SupersetSectionModel({
    required this.sets,
    required this.exercises,
  });

  List<Map<String, ISet>> sets;
  List<ExerciseModel> exercises;

  String get title => 'Title';
  List<Map<String, ISet>> get completedSets {
    final test = List<Map<String, ISet>>.from(sets);
    return test
        .map((e) => e..removeWhere((key, value) => value.isComplete))
        .toList();
  }

  @override
  ISet? bestSet() {
    return null;
  }

  @override
  double getVolume({Units units = Units.kgs}) {
    return completedSets.fold(0, (previousValue, element) {
      final test = element.values.fold<double>(0, (previousValue, element) {
        return previousValue + element.getVolume(units: units);
      });

      return previousValue + test;
    });
  }

  @override
  int getCompletedSets() => 0;

  @override
  HistoricSectionEntity? toEntity() {
    final setsToAdd = completedSets.map(
      (e) => HistoricSupersetWrapperEntity(superSetString: e.keys.toList())
        ..sets.addAll(e.values.map((e) => e.toEntity()!)),
    );

    final cleanedSets = setsToAdd.where((e) => e.sets.isNotEmpty).toList();
    if (cleanedSets.isEmpty) return null;

    final supersetSection = HistoricSupersetSectionEntity(title: title)
      ..supersets.addAll(cleanedSets);
    return HistoricSectionEntity()..supersetSection.target = supersetSection;
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class ISet with ISetMappable {
  double getVolume({Units units = Units.kgs});
  bool get isComplete;
  HistoricSetEntity? toEntity();
}

@MappableClass(discriminatorValue: 'default')
class DefaultSetModel with DefaultSetModelMappable implements ISet {
  DefaultSetModel({
    required this.sectionIndex,
    required this.setIndex,
    required this.exercise,
    this.setString = '',
    this.reps,
    this.load,
    this.units,
    this.timeOfCompletion,
  });

  final int sectionIndex;
  final int setIndex;
  final String setString;

  final int? reps;
  final double? load;
  final Units? units;
  final DateTime? timeOfCompletion;

  final ExerciseModel exercise;

  double? get loadInKg => (units == Units.kgs) ? load : lbsToKgs(load ?? 0);
  double? get loadInLbs => (units == Units.lbs) ? load : kgsToLbs(load ?? 0);

  @override
  bool get isComplete =>
      reps != null && load != null && units != null && timeOfCompletion != null;

  @override
  double getVolume({Units units = Units.kgs}) {
    if (!isComplete) return 0;
    return (units == Units.kgs) ? loadInKg! * reps! : loadInLbs! * reps!;
  }

  @override
  HistoricSetEntity? toEntity() {
    if (!isComplete) return null;

    final defaultSet = HistoricDefaultSetEntity(
      reps: reps!,
      load: load!,
      units: units!.index,
      timeOfCompletion: timeOfCompletion!,
    );

    return HistoricSetEntity()
      ..defaultSet.target = defaultSet
      ..exercise.target = exercise.toEntity();
  }
}
