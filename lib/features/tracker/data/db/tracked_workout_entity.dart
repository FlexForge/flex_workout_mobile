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
    this.id = 0,
  });

  @Id()
  int id = 0;

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
      setNumber: 0,
      defaultSet: defaultSet.target?.toModel(),
      superSet: superSet.map((e) => e.toModel()).toList(),
    );
  }
}

@Entity()
class SetType {
  SetType({
    this.id = 0,
  });

  @Id()
  int id = 0;

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
      exercise: exercise.target!.toModel(),
      normalSet: normalSet.target?.toModel(),
    );
  }
}

@Entity()
class NormalSet {
  NormalSet({
    this.id = 0,
  });

  @Id()
  int id = 0;
}

extension ConvertNormalSet on NormalSet {
  NormalSetModel toModel() => NormalSetModel(
        id: id,
      );
}
