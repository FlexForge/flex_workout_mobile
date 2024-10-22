import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class WorkoutEntity {
  WorkoutEntity({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.updatedAt,
    required this.createdAt,
    this.id = 0,
  });

  @Backlink('workout')
  final sections = ToMany<WorkoutSectionEntity>();

  @Id()
  int id = 0;

  String title;
  String subtitle;
  String description;

  @Property(type: PropertyType.date)
  DateTime updatedAt;
  @Property(type: PropertyType.date)
  DateTime createdAt;
}

extension ConvertWorkout on WorkoutEntity {
  WorkoutModel toModel() => WorkoutModel(
        id: id,
        title: title,
        subtitle: subtitle,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
        sections: sections.map((e) => e.toModel()).toList(),
      );
}

@Entity()
class WorkoutSectionEntity {
  WorkoutSectionEntity({this.id = 0});

  @Id()
  int id = 0;

  final workout = ToOne<WorkoutEntity>();

  final defaultSection = ToOne<DefaultSectionEntity>();
}

extension ConvertSection on WorkoutSectionEntity {
  IWorkoutSection toModel() {
    if (defaultSection.target != null) {
      return defaultSection.target!.toModel();
    } else {
      return defaultSection.target!.toModel();
    }
  }
}

@Entity()
class DefaultSectionEntity {
  DefaultSectionEntity({
    required this.title,
    this.id = 0,
  });

  @Id()
  int id = 0;

  String title;
  final sets = ToMany<SetEntity>();
}

extension ConvertHistoricDefaultSection on DefaultSectionEntity {
  IWorkoutSection toModel() {
    return DefaultWorkoutSectionModel(
      id: id,
      title: title,
      sets: sets.map((e) => e.toModel()).toList(),
    );
  }
}

@Entity()
class SetEntity {
  SetEntity({this.id = 0});

  @Id()
  int id = 0;

  final defaultSection = ToOne<DefaultSectionEntity>();

  final defaultSet = ToOne<DefaultSetEntity>();
}

extension ConvertHistoricSet on SetEntity {
  IWorkoutSet toModel() {
    return defaultSet.target!.toModel();
  }
}

@Entity()
class DefaultSetEntity {
  DefaultSetEntity({
    required this.minReps,
    this.maxReps,
    this.id = 0,
  });

  @Id()
  int id = 0;

  int minReps;
  int? maxReps;

  final exercise = ToOne<ExerciseEntity>();
}

extension ConvertHistoricDefaultSet on DefaultSetEntity {
  IWorkoutSet toModel() {
    return DefaultWorkoutSetModel(
      id: id,
      minReps: minReps,
      maxReps: maxReps,
      exercise: exercise.target!.toModel(),
    );
  }
}
