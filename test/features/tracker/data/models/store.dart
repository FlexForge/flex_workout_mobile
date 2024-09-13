import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/live_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';

import '../../../exercise/data/db/store.dart';


///
/// Hardcoded Data
///

final exampleSectionOne = WorkoutSectionModel(
  id: 1,
  title: 'Example Section 1',
  organizers: [
    SetOrganizerModel(
      id: 1,
      organization: SetOrganizationEnum.defaultSet,
      defaultSet: SetTypeModel(
        id: 1,
        exercise: exampleExerciseOne,
        type: SetTypeEnum.normalSet,
        normalSet:
            const NormalSetModel(id: 1, reps: 10, load: 100, units: Units.kgs),
      ),
      setNumber: 1,
    ),
    SetOrganizerModel(
      id: 3,
      organization: SetOrganizationEnum.defaultSet,
      defaultSet: SetTypeModel(
        id: 4,
        exercise: exampleExerciseOne,
        type: SetTypeEnum.normalSet,
        normalSet: const NormalSetModel(
          id: 4,
          reps: 10,
          load: 100,
          units: Units.kgs,
        ),
      ),
      setNumber: 2,
    ),
  ],
);

final exampleSectionTwo = WorkoutSectionModel(
  id: 2,
  title: 'Example Section 2',
  organizers: [
    SetOrganizerModel(
      id: 2,
      organization: SetOrganizationEnum.superSet,
      superSet: [
        SetTypeModel(
          id: 2,
          exercise: exampleExerciseTwo,
          type: SetTypeEnum.normalSet,
          normalSet: const NormalSetModel(
            id: 2,
            reps: 10,
            load: 100,
            units: Units.kgs,
          ),
        ),
        SetTypeModel(
          id: 3,
          exercise: exampleExerciseThree,
          type: SetTypeEnum.normalSet,
          normalSet: const NormalSetModel(
            id: 3,
            reps: 10,
            load: 100,
            units: Units.kgs,
          ),
        ),
      ],
      setNumber: 1,
    ),
    SetOrganizerModel(
      id: 4,
      organization: SetOrganizationEnum.superSet,
      superSet: [
        SetTypeModel(
          id: 5,
          exercise: exampleExerciseTwo,
          type: SetTypeEnum.normalSet,
          normalSet: const NormalSetModel(
            id: 5,
            reps: 10,
            load: 100,
            units: Units.kgs,
          ),
        ),
        SetTypeModel(
          id: 6,
          exercise: exampleExerciseThree,
          type: SetTypeEnum.normalSet,
          normalSet: const NormalSetModel(
            id: 6,
            reps: 10,
            load: 100,
            units: Units.kgs,
          ),
        ),
      ],
      setNumber: 2,
    ),
  ],
);

final exampleWorkout = TrackedWorkoutModel(
  id: 1,
  title: 'Example Workout',
  subtitle: 'Morning Workout',
  notes: 'Example notes',
  durationInMinutes: 60,
  startTimestamp: DateTime(2024),
  sections: [exampleSectionOne, exampleSectionTwo],
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);

///
/// Random Generators
///

LiveWorkoutModel generateLiveWorkout({
  bool generateSections = false,
}) {
  return LiveWorkoutModel(
    subtitle:
        faker.lorem.words(faker.randomGenerator.integer(5, min: 1)).join(' '),
    startTimestamp: faker.date.dateTimeBetween(
      DateTime(2024),
      DateTime.now().subtract(const Duration(days: 1)),
    ),
    sections: generateSections
        ? List.generate(
            faker.randomGenerator.integer(5, min: 1),
            (index) => generateLiveSection(sectionIndex: index),
          )
        : [],
  );
}

ILiveSection<dynamic> generateLiveSection({
  required int sectionIndex,
}) {
  final type = faker.randomGenerator.integer(1);

  if (type == 1) {
    final sets = List.generate(
      faker.randomGenerator.integer(5, min: 1),
      (index) => generateLiveSet(sectionIndex: index, setIndex: index),
    );
    return LiveDefaultSectionModel(sets: sets, templateSet: sets.first);
  }

  final sets = List.generate(
    faker.randomGenerator.integer(5, min: 1),
    (setIndex) {
      final sets = faker.randomGenerator.integer(5, min: 1);
      return Map.fromEntries(
        List.generate(sets, (index) {
          final key = String.fromCharCode(65 + index);
          return MapEntry(
            key,
            generateLiveSet(
              sectionIndex: sectionIndex,
              setIndex: setIndex,
              setString: key,
            ),
          );
        }),
      );
    },
  );
  return LiveSupersetSectionModel(sets: sets, templateSet: sets.first);
}

ILiveSet generateLiveSet({
  required int sectionIndex,
  required int setIndex,
  String setString = '',
}) {
  return LiveDefaultSetModel(
    exercise: generateRandomExercise(),
    sectionIndex: sectionIndex,
    setIndex: setIndex,
    setString: setString,
    isComplete: faker.randomGenerator.boolean(),
    reps: faker.randomGenerator.integer(20, min: 1),
    load: faker.randomGenerator.integer(100, min: 1).toDouble(),
    units: Units.values[faker.randomGenerator.integer(Units.values.length)],
  );
}

TrackedWorkoutModel generateTrackedWorkout({
  bool generateSections = false,
}) {
  return TrackedWorkoutModel(
    id: faker.randomGenerator.integer(9999999),
    title:
        faker.lorem.words(faker.randomGenerator.integer(5, min: 1)).join(' '),
    subtitle:
        faker.lorem.words(faker.randomGenerator.integer(3, min: 1)).join(' '),
    notes: faker.lorem.sentences(5).join(' '),
    durationInMinutes: faker.randomGenerator.integer(180, min: 20),
    startTimestamp: faker.date.dateTimeBetween(
      DateTime(2024),
      DateTime.now().subtract(const Duration(days: 1)),
    ),
    updatedAt: DateTime.now(),
    createdAt: DateTime.now(),
    sections: generateSections
        ? List.generate(
            faker.randomGenerator.integer(5, min: 1),
            (index) => WorkoutSectionModel(
              id: faker.randomGenerator.integer(9999999),
              title: faker.lorem
                  .words(faker.randomGenerator.integer(5, min: 1))
                  .join(' '),
              organizers: List.generate(
                faker.randomGenerator.integer(5, min: 1),
                (index) {
                  final organization = SetOrganizationEnum
                      .values[faker.randomGenerator.integer(2)];
                  return SetOrganizerModel(
                    id: faker.randomGenerator.integer(9999999),
                    organization: organization,
                    defaultSet: organization == SetOrganizationEnum.defaultSet
                        ? SetTypeModel(
                            id: faker.randomGenerator.integer(9999999),
                            exercise: masterExercises.first.toModel(),
                            type: SetTypeEnum.normalSet,
                            normalSet: NormalSetModel(
                              id: faker.randomGenerator.integer(9999999),
                              reps: faker.randomGenerator.integer(20, min: 1),
                              load: faker.randomGenerator
                                  .integer(100, min: 1)
                                  .toDouble(),
                              units: Units.values[faker.randomGenerator
                                  .integer(Units.values.length)],
                            ),
                          )
                        : null,
                    superSet: organization == SetOrganizationEnum.superSet
                        ? List.generate(
                            faker.randomGenerator.integer(5, min: 1),
                            (index) => SetTypeModel(
                              id: faker.randomGenerator.integer(9999999),
                              exercise: masterExercises.first.toModel(),
                              type: SetTypeEnum.normalSet,
                              normalSet: NormalSetModel(
                                id: faker.randomGenerator.integer(9999999),
                                reps: faker.randomGenerator.integer(20, min: 1),
                                load: faker.randomGenerator
                                    .integer(100, min: 1)
                                    .toDouble(),
                                units: Units.values[faker.randomGenerator
                                    .integer(Units.values.length)],
                              ),
                            ),
                          ).toList()
                        : [],
                    setNumber: 1,
                  );
                },
              ),
            ),
          )
        : [],
  );
}

List<TrackedWorkoutModel> generateTrackedWorkouts(
  int amount, {
  bool generateSections = false,
}) {
  return List.generate(amount, (index) {
    return generateTrackedWorkout(generateSections: generateSections);
  });
}
