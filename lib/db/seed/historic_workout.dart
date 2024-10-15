import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/db/seed/muscle_groups.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';
import 'package:fpdart/fpdart.dart';

class DefaultSectionGenerator {
  static HistoricDefaultSectionModel single({
    required ExerciseModel exercise,
    required int numberOfSets,
    required DateTime setStartTime,
    required int minRepRange,
    required int maxRepRange,
    required double topSetLoad,
  }) {
    return HistoricDefaultSectionModel(
      id: 0,
      title: exercise.name,
      sets: List.generate(
        numberOfSets,
        (index) => HistoricDefaultSetModel(
          id: 0,
          reps:
              faker.randomGenerator.integer(maxRepRange + 1, min: minRepRange),
          load: topSetLoad - (5 * faker.randomGenerator.integer(index + 1)),
          units: Units.lbs,
          exercise: exercise,
          timeOfCompletion: setStartTime,
        ),
      ),
    );
  }
}

final workoutTemplate = [
  HistoricWorkoutModel(
    sections: [],
    id: 0,
    title: 'Day 1 • Upper',
    subtitle: 'Guts Training Program',
    notes: '',
    startTimestamp: DateTime.now(),
    endTimestamp: DateTime.now(),
    primaryMuscleGroups: [
      chest.toModel(),
      lats.toModel(),
      frontDelts.toModel(),
      abs.toModel(),
      triceps.toModel(),
      neck.toModel(),
    ],
    secondaryMuscleGroups: [
      rearDelts.toModel(),
      midBack.toModel(),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  HistoricWorkoutModel(
    sections: [],
    id: 0,
    title: 'Day 2 • Full Body',
    subtitle: 'Guts Training Program',
    notes: '',
    startTimestamp: DateTime.now(),
    endTimestamp: DateTime.now(),
    primaryMuscleGroups: [
      lats.toModel(),
      biceps.toModel(),
      quads.toModel(),
      hamstrings.toModel(),
      midBack.toModel(),
      midDelts.toModel(),
    ],
    secondaryMuscleGroups: [
      rearDelts.toModel(),
      abs.toModel(),
      glutes.toModel(),
      calves.toModel(),
      forearms.toModel(),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  HistoricWorkoutModel(
    sections: [],
    id: 0,
    title: 'Day 3 • Upper',
    subtitle: 'Guts Training Program',
    notes: '',
    startTimestamp: DateTime.now(),
    endTimestamp: DateTime.now(),
    primaryMuscleGroups: [
      triceps.toModel(),
      biceps.toModel(),
      chest.toModel(),
      neck.toModel(),
      abs.toModel(),
    ],
    secondaryMuscleGroups: [
      frontDelts.toModel(),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  HistoricWorkoutModel(
    sections: [],
    id: 0,
    title: 'Day 4 • Lower',
    subtitle: 'Guts Training Program',
    notes: '',
    startTimestamp: DateTime.now(),
    endTimestamp: DateTime.now(),
    primaryMuscleGroups: [
      lowerBack.toModel(),
      hamstrings.toModel(),
      calves.toModel(),
      quads.toModel(),
      biceps.toModel(),
      midBack.toModel(),
      midDelts.toModel(),
      frontDelts.toModel(),
    ],
    secondaryMuscleGroups: [
      abs.toModel(),
      forearms.toModel(),
      glutes.toModel(),
      lats.toModel(),
      rearDelts.toModel(),
    ],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

final upperSectionOneTemplate =
    HistoricDefaultSectionModel(id: 0, title: '', sets: []);

final startDate = DateTime.now().subtract(const Duration(days: 84));

final historicWorkouts =
    List.generate(12, (index) => index).flatMap((weekIndex) {
  final weekStartDate = startDate.add(Duration(days: weekIndex * 7));

  var weekDay = 0;
  return workoutTemplate.mapWithIndex((workout, dayIndex) {
    weekDay = min(weekDay + 1 + faker.randomGenerator.integer(2), 7);

    final workoutStartDate = weekStartDate.add(Duration(days: weekDay));
    final workoutDuration = faker.randomGenerator.integer(99, min: 30);
    return workout.copyWith(
      startTimestamp: workoutStartDate,
      endTimestamp: workoutStartDate.add(Duration(minutes: workoutDuration)),
      createdAt: workoutStartDate.add(Duration(minutes: workoutDuration)),
      updatedAt: workoutStartDate.add(Duration(minutes: workoutDuration)),
      sections: [
        if (dayIndex == 0)
          DefaultSectionGenerator.single(
            exercise: barbellBenchPress.toModel(),
            numberOfSets: faker.randomGenerator.integer(4, min: 2),
            setStartTime: workoutStartDate,
            minRepRange: 3,
            maxRepRange: 5,
            topSetLoad: 195 + (2.5 * weekIndex),
          ),
        if (dayIndex == 1)
          DefaultSectionGenerator.single(
            exercise: weightedChinUps.toModel(),
            numberOfSets: faker.randomGenerator.integer(4, min: 2),
            setStartTime: workoutStartDate,
            minRepRange: 3,
            maxRepRange: 5,
            topSetLoad: 35 + (2.5 * weekIndex),
          ),
        if (dayIndex == 2)
          DefaultSectionGenerator.single(
            exercise: closeGripBarbellBenchPress.toModel(),
            numberOfSets: faker.randomGenerator.integer(4, min: 2),
            setStartTime: workoutStartDate,
            minRepRange: 6,
            maxRepRange: 10,
            topSetLoad: 155 + (2.5 * weekIndex),
          ),
        if (dayIndex == 3)
          DefaultSectionGenerator.single(
            exercise: barbellDeadlift.toModel(),
            numberOfSets: faker.randomGenerator.integer(4, min: 2),
            setStartTime: workoutStartDate,
            minRepRange: 3,
            maxRepRange: 3,
            topSetLoad: 350 + (5.0 * weekIndex),
          ),
      ],
    );
  }).toList();
}).toList();

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
