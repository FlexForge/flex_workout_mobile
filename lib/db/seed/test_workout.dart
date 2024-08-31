import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/workout_section_entity.dart';

/// Temp seed data for testing
final workoutSection = WorkoutSection(title: 'Section 1');

final setOrganizer = SetOrganizer();

final setType = SetType();

/// Section 1: Bench Press

/// Set 1: Bench Press
SetType setOne = SetType()
  ..exercise.target = barbellBenchPress
  ..normalSet.target = NormalSet();
final organizerOne = SetOrganizer()..defaultSet.target = setOne;

/// Set 2: Bench Press
final setTwo = SetType()
  ..exercise.target = barbellBenchPress
  ..normalSet.target = NormalSet();
final organizerTwo = SetOrganizer()..defaultSet.target = setTwo;

/// Set 3: Bench Press
final setThree = SetType()
  ..exercise.target = barbellBenchPress
  ..normalSet.target = NormalSet();
final organizerThree = SetOrganizer()..defaultSet.target = setThree;

final benchPress = WorkoutSection(title: 'Bench Press')
  ..organizers.addAll([organizerOne, organizerTwo, organizerThree]);

/// Section 2: Incline Press and Neck Extension (Superset)

/// Set 1
final superSetOne = SetType()
  ..exercise.target = barbellInclineBenchPress
  ..normalSet.target = NormalSet();
final superSetOneTwo = SetType()
  ..exercise.target = plateLoadedNeckExtension
  ..normalSet.target = NormalSet();

final superOrganizerOne = SetOrganizer()
  ..superSet.addAll([superSetOne, superSetOneTwo]);

/// Set 2
final superSetTwo = SetType()
  ..exercise.target = barbellInclineBenchPress
  ..normalSet.target = NormalSet();
final superSetTwoTwo = SetType()
  ..exercise.target = plateLoadedNeckExtension
  ..normalSet.target = NormalSet();

final superOrganizerTwo = SetOrganizer()
  ..superSet.addAll([superSetTwo, superSetTwoTwo]);

/// Set 3
final superSetThree = SetType()
  ..exercise.target = barbellInclineBenchPress
  ..normalSet.target = NormalSet();
final superSetThreeTwo = SetType()
  ..exercise.target = plateLoadedNeckExtension
  ..normalSet.target = NormalSet();

final superOrganizerThree = SetOrganizer()
  ..superSet.addAll([superSetThree, superSetThreeTwo]);

final inclinePressAndNeckExtension =
    WorkoutSection(title: 'Incline Press and Neck Extension (Superset)')
      ..organizers
          .addAll([superOrganizerOne, superOrganizerTwo, superOrganizerThree]);

/// Section 3: Other Superset

/// Set 1
final superSetOne1 = SetType()
  ..exercise.target = jmPress
  ..normalSet.target = NormalSet();
final superSetOneTwo1 = SetType()
  ..exercise.target = landmineObliqueTwist
  ..normalSet.target = NormalSet();

final superOrganizerOne1 = SetOrganizer()
  ..superSet.addAll([superSetOne1, superSetOneTwo1]);

/// Set 2
final superSetTwo1 = SetType()
  ..exercise.target = jmPress
  ..normalSet.target = NormalSet();
final superSetTwoTwo1 = SetType()
  ..exercise.target = landmineObliqueTwist
  ..normalSet.target = NormalSet();

final superOrganizerTwo1 = SetOrganizer()
  ..superSet.addAll([superSetTwo1, superSetTwoTwo1]);

/// Set 3
final superSetThree1 = SetType()
  ..exercise.target = jmPress
  ..normalSet.target = NormalSet();

final superOrganizerThree1 = SetOrganizer()..superSet.addAll([superSetThree1]);

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
