import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/db/seed/master_exercises.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_section_model.dart';

List<TrackedWorkoutModel> generateTrackedWorkouts(
  int amount, {
  bool generateSections = false,
}) {
  final trackedWorkouts = <TrackedWorkoutModel>[];

  for (var i = 0; i < amount; i++) {
    trackedWorkouts.add(
      TrackedWorkoutModel(
        id: faker.randomGenerator.integer(9999999),
        title: faker.lorem
            .words(faker.randomGenerator.integer(5, min: 1))
            .join(' '),
        subtitle: faker.lorem
            .words(faker.randomGenerator.integer(3, min: 1))
            .join(' '),
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
                        defaultSet: organization ==
                                SetOrganizationEnum.defaultSet
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
      ),
    );
  }

  return trackedWorkouts;
}
