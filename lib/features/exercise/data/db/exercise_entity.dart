import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Exercise {
  Exercise({
    required this.name,
    required this.updatedAt,
    required this.createdAt,
    this.id = 0,
    this.description,
    this.videoUrl,
    this.equipment = Equipment.other,
    this.movementPattern = MovementPattern.other,
  });

  @Id()
  int id = 0;

  String name;
  String? description;

  String? videoUrl;

  @Transient()
  Equipment equipment;

  int get dbEquipment {
    return equipment.index;
  }

  set dbEquipment(int value) {
    equipment = value >= 0 && value < Equipment.values.length
        ? Equipment.values[value]
        : Equipment.other;
  }

  @Transient()
  MovementPattern movementPattern;

  int get dbMovementPattern {
    return movementPattern.index;
  }

  set dbMovementPattern(int value) {
    movementPattern = value >= 0 && value < MovementPattern.values.length
        ? MovementPattern.values[value]
        : MovementPattern.other;
  }

  @Property(type: PropertyType.date)
  DateTime updatedAt;
  @Property(type: PropertyType.date)
  DateTime createdAt;
}

extension ConvertExercise on Exercise {
  ExerciseModel toModel() => ExerciseModel(
        id: id,
        name: name,
        description: description,
        videoUrl: videoUrl,
        equipment: equipment,
        movementPattern: movementPattern,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
}
