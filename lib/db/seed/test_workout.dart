import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';

/// Temp seed data for testing
final workoutSection = WorkoutSection(title: 'Section 1');

final setOrganizer = SetOrganizer(setNumber: 1);

final setType = SetType();

/// Section 1: Bench Press

/// Set 1: Bench Press
SetType setOne = SetType()
  ..exercise.target = barbellBenchPress
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );
final organizerOne = SetOrganizer(setNumber: 1)..defaultSet.target = setOne;

/// Set 2: Bench Press
final setTwo = SetType()
  ..exercise.target = barbellBenchPress
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );
final organizerTwo = SetOrganizer(setNumber: 2)..defaultSet.target = setTwo;

/// Set 3: Bench Press
final setThree = SetType()
  ..exercise.target = barbellBenchPress
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );
final organizerThree = SetOrganizer(setNumber: 3)..defaultSet.target = setThree;

final benchPress = WorkoutSection(title: 'Bench Press')
  ..organizers.addAll([organizerOne, organizerTwo, organizerThree]);

/// Section 2: Incline Press and Neck Extension (Superset)

/// Set 1
final superSetOne = SetType()
  ..exercise.target = barbellInclineBenchPress
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );
final superSetOneTwo = SetType()
  ..exercise.target = plateLoadedNeckExtension
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );

final superOrganizerOne = SetOrganizer(setNumber: 1)
  ..superSet.addAll([superSetOne, superSetOneTwo]);

/// Set 2
final superSetTwo = SetType()
  ..exercise.target = barbellInclineBenchPress
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );
final superSetTwoTwo = SetType()
  ..exercise.target = plateLoadedNeckExtension
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );

final superOrganizerTwo = SetOrganizer(
  setNumber: 2,
)..superSet.addAll([superSetTwo, superSetTwoTwo]);

/// Set 3
final superSetThree = SetType()
  ..exercise.target = barbellInclineBenchPress
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );
final superSetThreeTwo = SetType()
  ..exercise.target = plateLoadedNeckExtension
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );

final superOrganizerThree = SetOrganizer(
  setNumber: 3,
)..superSet.addAll([superSetThree, superSetThreeTwo]);

final inclinePressAndNeckExtension =
    WorkoutSection(title: 'Incline Press and Neck Extension (Superset)')
      ..organizers
          .addAll([superOrganizerOne, superOrganizerTwo, superOrganizerThree]);

/// Section 3: Other Superset

/// Set 1
final superSetOne1 = SetType()
  ..exercise.target = jmPress
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );
final superSetOneTwo1 = SetType()
  ..exercise.target = landmineObliqueTwist
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );

final superOrganizerOne1 = SetOrganizer(
  setNumber: 1,
)..superSet.addAll([superSetOne1, superSetOneTwo1]);

/// Set 2
final superSetTwo1 = SetType()
  ..exercise.target = jmPress
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );
final superSetTwoTwo1 = SetType()
  ..exercise.target = landmineObliqueTwist
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );

final superOrganizerTwo1 = SetOrganizer(
  setNumber: 2,
)..superSet.addAll([superSetTwo1, superSetTwoTwo1]);

/// Set 3
final superSetThree1 = SetType()
  ..exercise.target = jmPress
  ..normalSet.target = NormalSet(
    reps: 10,
    load: 100,
  );

final superOrganizerThree1 = SetOrganizer(setNumber: 3)
  ..superSet.addAll([superSetThree1]);

final inclinePressAndNeckExtension1 =
    WorkoutSection(title: 'Incline Press and Neck Extension (Superset)')
      ..organizers.addAll(
        [superOrganizerOne1, superOrganizerTwo1, superOrganizerThree1],
      );

final exampleWorkout = TrackedWorkout(
  title: 'Test Workout',
  subtitle: 'Subtitle',
  durationInMinutes: 0,
  startTimestamp: DateTime.now(),
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)..sections.addAll(
    [benchPress, inclinePressAndNeckExtension, inclinePressAndNeckExtension1],
  );
