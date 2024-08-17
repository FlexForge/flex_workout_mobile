import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TrackedWorkout {
  TrackedWorkout({
    required this.title,
    required this.subtitle,
    required this.notes,
    required this.durationInMinutes,
    required this.startTimestamp,
    required this.updatedAt,
    required this.createdAt,
    this.id = 0,
  });

  @Id()
  int id = 0;

  String title;
  String subtitle;

  String notes;

  int durationInMinutes;

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
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
}
