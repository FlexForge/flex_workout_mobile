import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
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

extension ConvertHistoricWorkout on HistoricWorkoutEntity {
  HistoricWorkoutModel toModel() => HistoricWorkoutModel(
        id: id,
        title: title,
        subtitle: subtitle,
        notes: notes,
        startTimestamp: startTimestamp,
        endTimestamp: endTimestamp,
        primaryMuscleGroups:
            primaryMuscleGroups.map((e) => e.toModel()).toList(),
        secondaryMuscleGroups:
            secondaryMuscleGroups.map((e) => e.toModel()).toList(),
        createdAt: createdAt,
        updatedAt: updatedAt,
        sections: sections.map((e) => e.toModel()).toList(),
      );
}

@Entity()
class HistoricSectionEntity {
  HistoricSectionEntity({this.id = 0});

  @Id()
  int id = 0;

  final workout = ToOne<HistoricWorkoutEntity>();

  final defaultSection = ToOne<HistoricDefaultSectionEntity>();
  final supersetSection = ToOne<HistoricSupersetSectionEntity>();
}

extension ConvertHistoricSection on HistoricSectionEntity {
  IHistoricSection toModel() {
    if (defaultSection.target != null) {
      return defaultSection.target!.toModel();
    } else {
      return supersetSection.target!.toModel();
    }
  }
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

extension ConvertHistoricDefaultSection on HistoricDefaultSectionEntity {
  IHistoricSection toModel() {
    return HistoricDefaultSectionModel(
      id: id,
      title: title,
      sets: sets.map((e) => e.toModel()).toList(),
    );
  }
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

extension ConvertHistoricSupersetSection on HistoricSupersetSectionEntity {
  IHistoricSection toModel() {
    return HistoricSupersetSectionModel(
      id: id,
      title: title,
      sets: supersets.map((e) => e.toModel()).toList(),
    );
  }
}

@Entity()
class HistoricSupersetWrapperEntity {
  HistoricSupersetWrapperEntity({required this.superSetString, this.id = 0});

  @Id()
  int id = 0;
  List<String> superSetString;

  final supersetSection = ToOne<HistoricSupersetSectionEntity>();

  final sets = ToMany<HistoricSetEntity>();
}

extension ConvertHistoricSupersetWrapper on HistoricSupersetWrapperEntity {
  Map<String, IHistoricSet> toModel() {
    return {
      for (final (index, e) in sets.indexed) superSetString[index]: e.toModel(),
    };
  }
}

@Entity()
class HistoricSetEntity {
  @Id()
  int id = 0;

  final defaultSection = ToOne<HistoricDefaultSectionEntity>();
  final supersetSection = ToOne<HistoricSupersetWrapperEntity>();

  final defaultSet = ToOne<HistoricDefaultSetEntity>();
}

extension ConvertHistoricSet on HistoricSetEntity {
  IHistoricSet toModel() {
    return defaultSet.target!.toModel();
  }
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

extension ConvertHistoricDefaultSet on HistoricDefaultSetEntity {
  IHistoricSet toModel() {
    return HistoricDefaultSetModel(
      id: id,
      reps: reps,
      load: load,
      units: Units.values[units],
      exercise: exercise.target!.toModel(),
    );
  }
}
