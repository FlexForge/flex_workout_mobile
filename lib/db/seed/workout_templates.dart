import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/db/seed/muscle_groups.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
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
  primaryMuscleGroups: [chest.toModel(), neck.toModel(), frontDelts.toModel()],
  secondaryMuscleGroups: [triceps.toModel()],
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
  sections: [
    WorkoutDefaultSectionModel(
      id: 0,
      title: 'Chin Ups (Weighted)',
      sets: [
        WorkoutDefaultSetModel(
          id: 0,
          minReps: 3,
          maxReps: 5,
          exercise: weightedChinUps.toModel(),
        ),
        WorkoutDefaultSetModel(
          id: 0,
          minReps: 3,
          maxReps: 5,
          exercise: weightedChinUps.toModel(),
        ),
        WorkoutDefaultSetModel(
          id: 0,
          minReps: 3,
          maxReps: 5,
          exercise: weightedChinUps.toModel(),
        ),
      ],
      templateSet: WorkoutDefaultSetModel(
        id: 0,
        minReps: 3,
        maxReps: 5,
        exercise: weightedChinUps.toModel(),
      ),
    ),
    WorkoutSupersetSectionModel(
      id: 0,
      title: 'Incline Bench Press (Barbell) and Neck Extension (Plate Loaded)',
      sets: [
        {
          'A': WorkoutDefaultSetModel(
            id: 0,
            minReps: 8,
            maxReps: 10,
            exercise: barbellInclineBenchPress.toModel(),
          ),
          'B': WorkoutDefaultSetModel(
            id: 0,
            minReps: 10,
            maxReps: 12,
            exercise: plateLoadedNeckExtension.toModel(),
          ),
        },
        {
          'A': WorkoutDefaultSetModel(
            id: 0,
            minReps: 6,
            maxReps: 8,
            exercise: barbellInclineBenchPress.toModel(),
          ),
          'B': WorkoutDefaultSetModel(
            id: 0,
            minReps: 8,
            maxReps: 10,
            exercise: plateLoadedNeckExtension.toModel(),
          ),
        },
        {
          'A': WorkoutDefaultSetModel(
            id: 0,
            minReps: 4,
            maxReps: 6,
            exercise: barbellInclineBenchPress.toModel(),
          ),
        },
      ],
      templateSet: {
        'A': WorkoutDefaultSetModel(
          id: 0,
          minReps: 8,
          maxReps: 10,
          exercise: barbellInclineBenchPress.toModel(),
        ),
        'B': WorkoutDefaultSetModel(
          id: 0,
          minReps: 10,
          maxReps: 12,
          exercise: plateLoadedNeckExtension.toModel(),
        ),
      },
    ),
  ],
);
