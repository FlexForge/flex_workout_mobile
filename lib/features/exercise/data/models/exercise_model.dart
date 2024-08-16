import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_model.freezed.dart';

@freezed
class ExerciseModel with _$ExerciseModel {
  const factory ExerciseModel({
    required int id,
    required String name,
    required Equipment equipment,
    required MovementPattern movementPattern,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? description,
    String? videoUrl,
  }) = _ExerciseModel;
}

extension ConvertExerciseModel on ExerciseModel {
  Exercise toEntity() => Exercise(
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

enum Equipment {
  barbell(readableName: 'Barbell'),
  dumbbell(readableName: 'Dumbbell'),
  kettlebell(readableName: 'Kettlebell'),
  machine(readableName: 'Machine'),
  bodyweight(readableName: 'Bodyweight'),
  cardio(readableName: 'Cardio'),
  smithMachine(readableName: 'Smith Machine'),
  cable(readableName: 'Cable'),
  other(readableName: 'Other');

  const Equipment({required this.readableName});

  final String readableName;
}

enum MovementPattern {
  squat(readableName: 'Squat'),
  hipHinge(readableName: 'Hip Hinge'),
  verticalPull(readableName: 'Vertical Pull'),
  verticalPush(readableName: 'Vertical Push'),
  horizontalPull(readableName: 'Horizontal Pull'),
  horizontalPush(readableName: 'Horizontal Push'),
  hipExtension(readableName: 'Hip Extension'),
  pullOver(readableName: 'Pull Over'),
  fly(readableName: 'Fly'),
  isolation(readableName: 'Isolation'),
  carrying(readableName: 'Carrying'),
  jumping(readableName: 'Jumping'),
  mobility(readableName: 'Mobility'),
  other(readableName: 'Other');

  const MovementPattern({required this.readableName});

  final String readableName;
}
