import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TrackedWorkoutEntity {
  TrackedWorkoutEntity({
    required this.title,
    required this.subtitle,
    required this.durationInMinutes,
    required this.startTimestamp,
    required this.updatedAt,
    required this.createdAt,
    this.id = 0,
    this.notes,
  });

  @Id()
  int id = 0;

  String title;
  String subtitle;

  String? notes;

  int durationInMinutes;

  @Backlink('workout')
  final sections = ToMany<WorkoutSectionEntity>();

  @Property(type: PropertyType.date)
  DateTime startTimestamp;

  @Property(type: PropertyType.date)
  DateTime updatedAt;
  @Property(type: PropertyType.date)
  DateTime createdAt;
}

extension ConvertTrackedWorkout on TrackedWorkoutEntity {
  TrackedWorkoutModel toModel() => TrackedWorkoutModel(
        id: id,
        title: title,
        subtitle: subtitle,
        notes: notes,
        durationInMinutes: durationInMinutes,
        startTimestamp: startTimestamp,
        sections: sections.map((e) => e.toModel()).toList(),
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
}

@Entity()
class WorkoutSectionEntity {
  WorkoutSectionEntity({
    required this.title,
    this.id = 0,
  });

  @Id()
  int id = 0;

  String title;

  final workout = ToOne<TrackedWorkoutEntity>();

  @Backlink('section')
  final organizers = ToMany<SetOrganizerEntity>();
}

extension ConvertWorkoutSection on WorkoutSectionEntity {
  WorkoutSectionModel toModel() => WorkoutSectionModel(
        id: id,
        title: title,
        organizers: organizers.map((e) => e.toModel()).toList(),
      );
}

@Entity()
class SetOrganizerEntity {
  SetOrganizerEntity({
    required this.setNumber,
    this.id = 0,
  });

  @Id()
  int id = 0;

  int setNumber;

  final section = ToOne<WorkoutSectionEntity>();

  @Backlink('superOrganizer')
  final superSet = ToMany<SetTypeEntity>();

  final defaultSet = ToOne<SetTypeEntity>();
}

extension ConvertSetOrganizer on SetOrganizerEntity {
  SetOrganizerModel toModel() {
    SetOrganizationEnum organization;

    if (defaultSet.target != null) {
      organization = SetOrganizationEnum.defaultSet;
    } else {
      organization = SetOrganizationEnum.superSet;
    }

    return SetOrganizerModel(
      id: id,
      organization: organization,
      setNumber: setNumber,
      defaultSet: defaultSet.target?.toModel(),
      superSet: superSet.map((e) => e.toModel()).toList(),
    );
  }
}

@Entity()
class SetTypeEntity {
  SetTypeEntity({
    this.setLetter,
    this.id = 0,
  });

  @Id()
  int id = 0;

  String? setLetter;

  final exercise = ToOne<ExerciseEntity>();

  final superOrganizer = ToOne<SetOrganizerEntity>();

  final normalSet = ToOne<NormalSetEntity>();
}

extension ConvertSetType on SetTypeEntity {
  SetTypeModel toModel() {
    const type = SetTypeEnum.normalSet;

    return SetTypeModel(
      id: id,
      type: type,
      setLetter: setLetter,
      exercise: exercise.target!.toModel(),
      normalSet: normalSet.target?.toModel(),
    );
  }
}

@Entity()
class NormalSetEntity {
  NormalSetEntity({
    required this.reps,
    required this.load,
    this.units = Units.lbs,
    this.id = 0,
  });

  @Id()
  int id = 0;

  int reps;
  double load;

  @Transient()
  Units units;

  int get dbUnits {
    return units.index;
  }

  set dbUnits(int value) {
    units = value >= 0 && value < Units.values.length
        ? Units.values[value]
        : Units.lbs;
  }
}

extension ConvertNormalSet on NormalSetEntity {
  NormalSetModel toModel() => NormalSetModel(
        id: id,
        reps: reps,
        load: load,
        units: units,
      );
}
