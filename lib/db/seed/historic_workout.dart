import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/db/seed/muscle_groups.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';

final exampleWorkout = HistoricWorkoutModel(
  id: 0,
  title: 'Example Workout',
  subtitle: 'Afternoon Workout',
  notes: 'Here are some notes about the workout',
  startTimestamp: DateTime.now(),
  endTimestamp: DateTime.now().add(const Duration(minutes: 57)),
  primaryMuscleGroups: [chest.toModel(), neck.toModel(), frontDelts.toModel()],
  secondaryMuscleGroups: [triceps.toModel()],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  sections: [
    HistoricDefaultSectionModel(
      id: 0,
      title: 'Barbell BenchPress',
      sets: [
        HistoricDefaultSetModel(
          id: 0,
          reps: 10,
          load: 100,
          units: Units.kgs,
          exercise: barbellBenchPress.toModel(),
          timeOfCompletion: DateTime.now().add(const Duration(minutes: 1)),
        ),
        HistoricDefaultSetModel(
          id: 0,
          reps: 10,
          load: 100,
          units: Units.kgs,
          exercise: barbellBenchPress.toModel(),
          timeOfCompletion: DateTime.now().add(const Duration(minutes: 2)),
        ),
        HistoricDefaultSetModel(
          id: 0,
          reps: 10,
          load: 100,
          units: Units.kgs,
          exercise: barbellBenchPress.toModel(),
          timeOfCompletion: DateTime.now().add(const Duration(minutes: 4)),
        ),
      ],
    ),
    HistoricSupersetSectionModel(
      id: 0,
      title: 'Incline BenchPress and Neck Extension',
      sets: [
        {
          'A': HistoricDefaultSetModel(
            id: 0,
            reps: 10,
            load: 100,
            units: Units.kgs,
            exercise: barbellInclineBenchPress.toModel(),
            timeOfCompletion: DateTime.now().add(const Duration(minutes: 10)),
          ),
          'B': HistoricDefaultSetModel(
            id: 0,
            reps: 10,
            load: 100,
            units: Units.kgs,
            exercise: plateLoadedNeckExtension.toModel(),
            timeOfCompletion: DateTime.now().add(const Duration(minutes: 11)),
          ),
        },
        {
          'A': HistoricDefaultSetModel(
            id: 0,
            reps: 10,
            load: 100,
            units: Units.kgs,
            exercise: barbellInclineBenchPress.toModel(),
            timeOfCompletion: DateTime.now().add(const Duration(minutes: 14)),
          ),
          'B': HistoricDefaultSetModel(
            id: 0,
            reps: 10,
            load: 100,
            units: Units.kgs,
            exercise: plateLoadedNeckExtension.toModel(),
            timeOfCompletion: DateTime.now().add(const Duration(minutes: 15)),
          ),
        },
        {
          'A': HistoricDefaultSetModel(
            id: 0,
            reps: 10,
            load: 100,
            units: Units.kgs,
            exercise: barbellInclineBenchPress.toModel(),
            timeOfCompletion: DateTime.now().add(const Duration(minutes: 20)),
          ),
        },
      ],
    ),
    HistoricDefaultSectionModel(
      id: 0,
      title: 'Dumbbell Shoulder Press',
      sets: [
        HistoricDefaultSetModel(
          id: 0,
          reps: 10,
          load: 100,
          units: Units.kgs,
          exercise: barbellAdPress.toModel(),
          timeOfCompletion: DateTime.now().add(const Duration(minutes: 25)),
        ),
        HistoricDefaultSetModel(
          id: 0,
          reps: 10,
          load: 100,
          units: Units.kgs,
          exercise: barbellAdPress.toModel(),
          timeOfCompletion: DateTime.now().add(const Duration(minutes: 30)),
        ),
      ],
    ),
  ],
);
