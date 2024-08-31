import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/workout_section_entity.dart';
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
    this.engagement = Engagement.bilateral,
    this.equipment = Equipment.other,
    this.movementPattern = MovementPattern.other,
  });

  @Id()
  int id = 0;

  String name;
  String? description;

  String? videoUrl;

  final primaryMuscleGroups = ToMany<MuscleGroup>();
  final secondaryMuscleGroups = ToMany<MuscleGroup>();

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

  @Backlink('exercise')
  final sets = ToMany<SetType>();

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
