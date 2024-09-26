import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'exercise_model.freezed.dart';

@freezed
class ExerciseModel with _$ExerciseModel {
  const factory ExerciseModel({
    required int id,
    required String name,
    required Equipment equipment,
    required MovementPattern movementPattern,
    required Engagement engagement,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<MuscleGroupModel> primaryMuscleGroups,
    @Default([]) List<MuscleGroupModel> secondaryMuscleGroups,
    String? description,
    String? videoUrl,
  }) = _ExerciseModel;
}

extension ConvertExerciseModel on ExerciseModel {
  ExerciseEntity toEntity() => ExerciseEntity(
        id: id,
        name: name,
        description: description,
        videoUrl: videoUrl,
        equipment: equipment,
        engagement: engagement,
        movementPattern: movementPattern,
        updatedAt: updatedAt,
        createdAt: createdAt,
      )
        ..primaryMuscleGroups
            .addAll(primaryMuscleGroups.map((e) => e.toEntity()))
        ..secondaryMuscleGroups
            .addAll(secondaryMuscleGroups.map((e) => e.toEntity()));
}

enum Engagement {
  bilateral(
    readableName: 'Bilateral',
    description: 'Exercises where both sides of the body work together.'
        ' For example a Squat or Bench Press.',
    icon: Symbols.keyboard_double_arrow_up,
  ),
  bilateralSeparate(
    readableName: 'Bilateral With Separate Weights',
    description: 'Exercise where both sides of the body work together,'
        ' but each side uses a separate weight. Ex: Dumbbell Bench Press',
    icon: Symbols.collapse_all,
  ),
  unilateral(
    readableName: 'Unilateral',
    description: 'Exercises where you work one side of the body at a time.'
        ' Ex: Bulgarian Split Squat or Lunges',
    icon: Symbols.keyboard_arrow_up,
  );

  const Engagement({
    required this.readableName,
    this.description,
    this.icon,
  });

  final String readableName;
  final String? description;
  final IconData? icon;
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
