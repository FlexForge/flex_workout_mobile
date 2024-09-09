import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TrackedWorkout {
  TrackedWorkout({
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
  final sections = ToMany<WorkoutSection>();

  @Property(type: PropertyType.date)
  DateTime startTimestamp;

  @Property(type: PropertyType.date)
  DateTime updatedAt;
  @Property(type: PropertyType.date)
  DateTime createdAt;
}

extension ConvertTrackedWorkout on TrackedWorkout {
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
class WorkoutSection {
  WorkoutSection({
    required this.title,
    this.id = 0,
  });

  @Id()
  int id = 0;

  String title;

  final workout = ToOne<TrackedWorkout>();

  @Backlink('section')
  final organizers = ToMany<SetOrganizer>();
}

extension ConvertWorkoutSection on WorkoutSection {
  WorkoutSectionModel toModel() => WorkoutSectionModel(
        id: id,
        title: title,
        organizers: organizers.map((e) => e.toModel()).toList(),
      );
}

@Entity()
class SetOrganizer {
  SetOrganizer({
    required this.setNumber,
    this.id = 0,
  });

  @Id()
  int id = 0;

  int setNumber;

  final section = ToOne<WorkoutSection>();

  @Backlink('superOrganizer')
  final superSet = ToMany<SetType>();

  final defaultSet = ToOne<SetType>();
}

extension ConvertSetOrganizer on SetOrganizer {
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
class SetType {
  SetType({
    this.setLetter,
    this.id = 0,
  });

  @Id()
  int id = 0;

  String? setLetter;

  final exercise = ToOne<Exercise>();

  final superOrganizer = ToOne<SetOrganizer>();

  final normalSet = ToOne<NormalSet>();
}

extension ConvertSetType on SetType {
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
class NormalSet {
  NormalSet({
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

extension ConvertNormalSet on NormalSet {
  NormalSetModel toModel() => NormalSetModel(
        id: id,
        reps: reps,
        load: load,
        units: units,
      );
}
