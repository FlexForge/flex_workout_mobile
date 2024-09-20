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

  final section = ToOne<HistoricSectionEntity>();
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

  final section = ToOne<HistoricSectionEntity>();
}
