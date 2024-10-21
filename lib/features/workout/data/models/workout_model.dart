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
    required this.sets,
  });

  final int id;
  List<IWorkoutSet> sets;

  @override
  WorkoutSectionEntity toEntity() {
    final defaultSection = DefaultSectionEntity(id: id)
      ..sets.addAll(sets.map((e) => e.toEntity()));
    return WorkoutSectionEntity(id: id)..defaultSection.target = defaultSection;
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
