import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class HistoricWorkoutEntity {
  HistoricWorkoutEntity({
    required this.title,
    required this.subtitle,
    required this.notes,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.updatedAt,
    required this.createdAt,
    this.id = 0,
  });

  @Backlink('workout')
  final sections = ToMany<HistoricSectionEntity>();

  @Id()
  int id = 0;

  String title;
  String subtitle;
  String notes;

  @Property(type: PropertyType.date)
  DateTime startTimestamp;
  @Property(type: PropertyType.date)
  DateTime endTimestamp;

  // Muscle Groups
  final primaryMuscleGroups = ToMany<MuscleGroupEntity>();
  final secondaryMuscleGroups = ToMany<MuscleGroupEntity>();

  @Property(type: PropertyType.date)
  DateTime updatedAt;
  @Property(type: PropertyType.date)
  DateTime createdAt;
}

@Entity()
class HistoricSectionEntity {
  @Id()
  int id = 0;

  final workout = ToOne<HistoricWorkoutEntity>();

  final defaultSection = ToOne<HistoricDefaultSectionEntity>();
  final supersetSection = ToOne<HistoricSupersetSectionEntity>();
}

@Entity()
class HistoricDefaultSectionEntity {
  HistoricDefaultSectionEntity({
    required this.title,
    this.id = 0,
  });

  @Id()
  int id = 0;
  String title;

  final sets = ToMany<HistoricSetEntity>();
}

@Entity()
class HistoricSupersetSectionEntity {
  HistoricSupersetSectionEntity({
    required this.title,
    this.id = 0,
  });

  @Id()
  int id = 0;
  String title;

  @Backlink('supersetSection')
  final supersets = ToMany<HistoricSupersetWrapperEntity>();
}

// Contains the sets within each superset
@Entity()
class HistoricSupersetWrapperEntity {
  @Id()
  int id = 0;

  final supersetSection = ToOne<HistoricSupersetSectionEntity>();

  final sets = ToMany<HistoricSetEntity>();
}

@Entity()
class HistoricSetEntity {
  @Id()
  int id = 0;

  final defaultSection = ToOne<HistoricDefaultSectionEntity>();
  final supersetSection = ToOne<HistoricSupersetWrapperEntity>();

  final defaultSet = ToOne<HistoricDefaultSetEntity>();
}

@Entity()
class HistoricDefaultSetEntity {
  HistoricDefaultSetEntity({
    required this.reps,
    required this.load,
    required this.units,
    this.id = 0,
  });

  @Id()
  int id = 0;

  int reps;
  double load;
  int units;

  final exercise = ToOne<ExerciseEntity>();
}
