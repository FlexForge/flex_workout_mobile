import 'package:flex_workout_mobile/features/tracker/data/db/workout_section_entity.dart';
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
