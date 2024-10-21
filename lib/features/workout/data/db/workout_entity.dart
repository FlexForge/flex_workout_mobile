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
      );
}
