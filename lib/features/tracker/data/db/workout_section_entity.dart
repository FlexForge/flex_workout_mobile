import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_section_model.dart';
import 'package:objectbox/objectbox.dart';

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
  SetOrganizerModel toModel() => SetOrganizerModel(
        id: id,
        defaultSet: defaultSet.target?.toModel(),
        superSet: superSet.map((e) => e.toModel()).toList(),
      );
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
  SetTypeModel toModel() => SetTypeModel(
        id: id,
        exercise: exercise.target!.toModel(),
        normalSet: normalSet.target?.toModel(),
      );
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
