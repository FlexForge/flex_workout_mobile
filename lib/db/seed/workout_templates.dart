import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';

final exampleWorkoutTemplate = WorkoutModel(
  id: 0,
  title: 'Day 1 • Bench Focus',
  subtitle: 'Power Building Phase 3.0',
  description:
      'This is a workout that is specifically designed for the second workout '
      "of every week in Jeff's Power Building Phase 3.0 program. "
      'The workout focuses on a single strict rep of bench with supplementary '
      'exercises following.',
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
  sections: [
    DefaultWorkoutSectionModel(
      id: 0,
      title: 'Chin Ups (Weighted)',
      sets: [
        DefaultWorkoutSetModel(
          id: 0,
          minReps: 3,
          maxReps: 5,
          exercise: weightedChinUps.toModel(),
        ),
        DefaultWorkoutSetModel(
          id: 0,
          minReps: 3,
          maxReps: 5,
          exercise: weightedChinUps.toModel(),
        ),
        DefaultWorkoutSetModel(
          id: 0,
          minReps: 3,
          maxReps: 5,
          exercise: weightedChinUps.toModel(),
        ),
      ],
    ),
    DefaultWorkoutSectionModel(
      id: 0,
      title: 'Second Exercise',
      sets: [
        DefaultWorkoutSetModel(
          id: 0,
          minReps: 1,
          exercise: weightedChinUps.toModel(),
        ),
        DefaultWorkoutSetModel(
          id: 0,
          minReps: 3,
          exercise: weightedChinUps.toModel(),
        ),
        DefaultWorkoutSetModel(
          id: 0,
          minReps: 3,
          maxReps: 5,
          exercise: weightedChinUps.toModel(),
        ),
      ],
    ),
    DefaultWorkoutSectionModel(
      id: 0,
      title: 'Second Exercise',
      sets: [
        DefaultWorkoutSetModel(
          id: 0,
          minReps: 1,
          exercise: weightedChinUps.toModel(),
        ),
      ],
    ),
  ],
);
