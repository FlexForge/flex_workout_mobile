import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';

/// Temp seed data for testing
final workoutSection = WorkoutSectionEntity(title: 'Section 1');

final setOrganizer = SetOrganizerEntity(setNumber: 1);

final setType = SetTypeEntity();

/// Section 1: Bench Press

/// Set 1: Bench Press
SetTypeEntity setOne = SetTypeEntity()
  ..exercise.target = barbellBenchPress
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );
final organizerOne = SetOrganizerEntity(setNumber: 1)
  ..defaultSet.target = setOne;

/// Set 2: Bench Press
final setTwo = SetTypeEntity()
  ..exercise.target = barbellBenchPress
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );
final organizerTwo = SetOrganizerEntity(setNumber: 2)
  ..defaultSet.target = setTwo;

/// Set 3: Bench Press
final setThree = SetTypeEntity()
  ..exercise.target = barbellBenchPress
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );
final organizerThree = SetOrganizerEntity(setNumber: 3)
  ..defaultSet.target = setThree;

final benchPress = WorkoutSectionEntity(title: 'Bench Press')
  ..organizers.addAll([organizerOne, organizerTwo, organizerThree]);

/// Section 2: Incline Press and Neck Extension (Superset)

/// Set 1
final superSetOne = SetTypeEntity()
  ..exercise.target = barbellInclineBenchPress
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );
final superSetOneTwo = SetTypeEntity()
  ..exercise.target = plateLoadedNeckExtension
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );

final superOrganizerOne = SetOrganizerEntity(setNumber: 1)
  ..superSet.addAll([superSetOne, superSetOneTwo]);

/// Set 2
final superSetTwo = SetTypeEntity()
  ..exercise.target = barbellInclineBenchPress
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );
final superSetTwoTwo = SetTypeEntity()
  ..exercise.target = plateLoadedNeckExtension
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );

final superOrganizerTwo = SetOrganizerEntity(
  setNumber: 2,
)..superSet.addAll([superSetTwo, superSetTwoTwo]);

/// Set 3
final superSetThree = SetTypeEntity()
  ..exercise.target = barbellInclineBenchPress
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );
final superSetThreeTwo = SetTypeEntity()
  ..exercise.target = plateLoadedNeckExtension
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );

final superOrganizerThree = SetOrganizerEntity(
  setNumber: 3,
)..superSet.addAll([superSetThree, superSetThreeTwo]);

final inclinePressAndNeckExtension =
    WorkoutSectionEntity(title: 'Incline Press and Neck Extension (Superset)')
      ..organizers
          .addAll([superOrganizerOne, superOrganizerTwo, superOrganizerThree]);

/// Section 3: Other Superset

/// Set 1
final superSetOne1 = SetTypeEntity()
  ..exercise.target = jmPress
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );
final superSetOneTwo1 = SetTypeEntity()
  ..exercise.target = landmineObliqueTwist
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );

final superOrganizerOne1 = SetOrganizerEntity(
  setNumber: 1,
)..superSet.addAll([superSetOne1, superSetOneTwo1]);

/// Set 2
final superSetTwo1 = SetTypeEntity()
  ..exercise.target = jmPress
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );
final superSetTwoTwo1 = SetTypeEntity()
  ..exercise.target = landmineObliqueTwist
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );

final superOrganizerTwo1 = SetOrganizerEntity(
  setNumber: 2,
)..superSet.addAll([superSetTwo1, superSetTwoTwo1]);

/// Set 3
final superSetThree1 = SetTypeEntity()
  ..exercise.target = jmPress
  ..normalSet.target = NormalSetEntity(
    reps: 10,
    load: 100,
  );

final superOrganizerThree1 = SetOrganizerEntity(setNumber: 3)
  ..superSet.addAll([superSetThree1]);

final inclinePressAndNeckExtension1 =
    WorkoutSectionEntity(title: 'Incline Press and Neck Extension (Superset)')
      ..organizers.addAll(
        [superOrganizerOne1, superOrganizerTwo1, superOrganizerThree1],
      );

final exampleWorkout = TrackedWorkoutEntity(
  title: 'Test Workout',
  subtitle: 'Subtitle',
  durationInMinutes: 0,
  startTimestamp: DateTime.now(),
  updatedAt: DateTime.now(),
  createdAt: DateTime.now(),
)..sections.addAll(
    [benchPress, inclinePressAndNeckExtension, inclinePressAndNeckExtension1],
  );
