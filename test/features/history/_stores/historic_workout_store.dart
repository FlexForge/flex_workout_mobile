import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/history/data/models/historic_workout_model.dart';

import '../../exercise/_stores/exercise_store.dart';
import '../../exercise/_stores/muscle_group_store.dart';

class HistoricWorkoutModelGenerator {
  static HistoricWorkoutModel single() {
    return HistoricWorkoutModel(
      id: faker.randomGenerator.integer(9999),
      title: faker.person.name(),
      subtitle: faker.company.name(),
      notes: faker.lorem.sentences(5).join(' '),
      startTimestamp: DateTime.now(),
      endTimestamp: DateTime.now(),
      primaryMuscleGroups: MuscleGroupModelGenerator.list(length: 2),
      secondaryMuscleGroups: MuscleGroupModelGenerator.list(length: 3),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      sections: IHistoricSectionGenerator.list(
        length: 4,
        organization: [1, 0, 1, 0],
      ),
    );
  }
}

class IHistoricSectionGenerator {
  static IHistoricSection single(int organization) {
    if (organization == 1) {
      return HistoricDefaultSectionModelGenerator.single();
    }
    return HistoricSupersetSectionModelGenerator.single();
  }

  static List<IHistoricSection> list({
    required int length,
    required List<int> organization,
  }) {
    return List.generate(length, (index) => single(organization[index]));
  }
}

class HistoricDefaultSectionModelGenerator {
  static HistoricDefaultSectionModel single() {
    return HistoricDefaultSectionModel(
      id: faker.randomGenerator.integer(9999),
      title: faker.person.name(),
      sets: IHistoricSetGenerator.list(length: 4),
    );
  }
}

class HistoricSupersetSectionModelGenerator {
  static HistoricSupersetSectionModel single() {
    return HistoricSupersetSectionModel(
      id: faker.randomGenerator.integer(9999),
      title: faker.person.name(),
      sets: List.generate(
        4,
        (index) {
          final list = List.generate(
            faker.randomGenerator.integer(4, min: 1),
            (index) => index,
          );

          return {
            for (final e in list)
              String.fromCharCode(65 + e): IHistoricSetGenerator.single(),
          };
        },
      ),
    );
  }
}

class IHistoricSetGenerator {
  static IHistoricSet single() {
    return HistoricDefaultSetModelGenerator.single();
  }

  static List<IHistoricSet> list({required int length}) {
    return List.generate(length, (_) => single());
  }
}

class HistoricDefaultSetModelGenerator {
  static HistoricDefaultSetModel single() {
    return HistoricDefaultSetModel(
      id: faker.randomGenerator.integer(9999),
      reps: faker.randomGenerator.integer(99, min: 1),
      load: faker.randomGenerator.decimal(scale: 10, min: 1),
      units: Units.kgs,
      exercise: ExerciseModelGenerator.single(),
    );
  }
}
