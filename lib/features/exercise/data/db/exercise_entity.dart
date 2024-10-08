import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ExerciseEntity {
  ExerciseEntity({
    required this.name,
    required this.updatedAt,
    required this.createdAt,
    this.id = 0,
    this.description,
    this.youtubeVideoId,
    this.engagement = Engagement.bilateral,
    this.equipment = Equipment.other,
    this.movementPattern = MovementPattern.other,
  });

  @Id()
  int id = 0;

  String name;
  String? description;

  String? youtubeVideoId;

  final primaryMuscleGroups = ToMany<MuscleGroupEntity>();
  final secondaryMuscleGroups = ToMany<MuscleGroupEntity>();

  @Transient()
  Engagement engagement;

  int get dbEngagement {
    return engagement.index;
  }

  set dbEngagement(int value) {
    engagement = value >= 0 && value < Engagement.values.length
        ? Engagement.values[value]
        : Engagement.bilateral;
  }

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

extension ConvertExercise on ExerciseEntity {
  ExerciseModel toModel() => ExerciseModel(
        id: id,
        name: name,
        description: description,
        youtubeVideoId: youtubeVideoId,
        primaryMuscleGroups:
            primaryMuscleGroups.map((e) => e.toModel()).toList(),
        secondaryMuscleGroups:
            secondaryMuscleGroups.map((e) => e.toModel()).toList(),
        engagement: engagement,
        equipment: equipment,
        movementPattern: movementPattern,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
}
