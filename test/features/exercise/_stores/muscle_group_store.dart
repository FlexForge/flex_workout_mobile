import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';

class MuscleGroupModelGenerator {
  static MuscleGroupModel single({DateTime? createdAt}) {
    return MuscleGroupModel(
      id: faker.randomGenerator.integer(9999),
      name: faker.person.name(),
      diagramPathNames: [],
      updatedAt: faker.date.dateTime(),
      createdAt: createdAt ?? faker.date.dateTime(),
    );
  }

  static List<MuscleGroupModel> list({required int length}) {
    return List.generate(length, (index) => single());
  }
}

class MuscleGroupEntityGenerator {
  static MuscleGroup single({DateTime? createdAt}) {
    return MuscleGroup(
      id: faker.randomGenerator.integer(9999),
      name: faker.person.name(),
      diagramPathNames: [],
      updatedAt: faker.date.dateTime(),
      createdAt: createdAt ?? faker.date.dateTime(),
    );
  }

  static List<MuscleGroup> list({required int length}) {
    return List.generate(length, (index) => single());
  }
}
