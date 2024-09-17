import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';

import 'muscle_group_store.dart';

class ExerciseModelGenerator {
  static ExerciseModel single({DateTime? createdAt}) {
    return ExerciseModel(
      id: faker.randomGenerator.integer(9999),
      name: faker.person.name(),
      description: faker.lorem.sentences(5).join(' '),
      videoUrl: faker.internet.httpsUrl(),
      equipment: Equipment.values[faker.randomGenerator.integer(8)],
      movementPattern:
          MovementPattern.values[faker.randomGenerator.integer(13)],
      engagement: Engagement.values[faker.randomGenerator.integer(2)],
      primaryMuscleGroups: MuscleGroupModelGenerator.list(length: 2),
      secondaryMuscleGroups: MuscleGroupModelGenerator.list(length: 3),
      updatedAt: faker.date.dateTime(),
      createdAt: createdAt ?? faker.date.dateTime(),
    );
  }

  static List<ExerciseModel> list({required int length}) {
    return List.generate(length, (index) => single());
  }
}

class ExerciseEntityGenerator {
  static ExerciseEntity single({DateTime? createdAt}) {
    return ExerciseEntity(
      id: faker.randomGenerator.integer(9999),
      name: faker.person.name(),
      description: faker.lorem.sentences(5).join(' '),
      videoUrl: faker.internet.httpsUrl(),
      equipment: Equipment.values[faker.randomGenerator.integer(8)],
      movementPattern:
          MovementPattern.values[faker.randomGenerator.integer(13)],
      engagement: Engagement.values[faker.randomGenerator.integer(2)],
      updatedAt: faker.date.dateTime(),
      createdAt: createdAt ?? faker.date.dateTime(),
    )
      ..primaryMuscleGroups.addAll(MuscleGroupEntityGenerator.list(length: 2))
      ..secondaryMuscleGroups
          .addAll(MuscleGroupEntityGenerator.list(length: 3));
  }

  static List<ExerciseEntity> list({required int length}) {
    return List.generate(length, (index) => single());
  }
}
