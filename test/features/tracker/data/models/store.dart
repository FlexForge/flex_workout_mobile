import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_section_model.dart';

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
        normalSet: const NormalSetModel(id: 1),
      ),
    ),
    SetOrganizerModel(
      id: 2,
      organization: SetOrganizationEnum.superSet,
      superSet: [
        SetTypeModel(
          id: 2,
          exercise: exampleExerciseTwo,
          type: SetTypeEnum.normalSet,
          normalSet: const NormalSetModel(id: 2),
        ),
        SetTypeModel(
          id: 3,
          exercise: exampleExerciseThree,
          type: SetTypeEnum.normalSet,
          normalSet: const NormalSetModel(id: 3),
        ),
      ],
    ),
  ],
);

final exampleSectionTwo = WorkoutSectionModel(
  id: 2,
  title: 'Example Section 2',
  organizers: [
    SetOrganizerModel(
      id: 3,
      organization: SetOrganizationEnum.defaultSet,
      defaultSet: SetTypeModel(
        id: 4,
        exercise: exampleExerciseOne,
        type: SetTypeEnum.normalSet,
        normalSet: const NormalSetModel(id: 4),
      ),
    ),
    SetOrganizerModel(
      id: 4,
      organization: SetOrganizationEnum.superSet,
      superSet: [
        SetTypeModel(
          id: 5,
          exercise: exampleExerciseOne,
          type: SetTypeEnum.normalSet,
          normalSet: const NormalSetModel(id: 5),
        ),
        SetTypeModel(
          id: 6,
          exercise: exampleExerciseTwo,
          type: SetTypeEnum.normalSet,
          normalSet: const NormalSetModel(id: 6),
        ),
      ],
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
                              ),
                            ),
                          ).toList()
                        : [],
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
