import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';

import '../../exercise/_stores/exercise_store.dart';

class TrackedWorkoutModelGenerator {
  static TrackedWorkoutModel single({DateTime? startTimestamp}) {
    return TrackedWorkoutModel(
      id: faker.randomGenerator.integer(9999),
      title: faker.person.name(),
      subtitle: faker.company.name(),
      notes: faker.lorem.sentences(5).join(' '),
      durationInMinutes: faker.randomGenerator.integer(99),
      startTimestamp: startTimestamp ?? faker.date.dateTime(),
      createdAt: faker.date.dateTime(),
      updatedAt: faker.date.dateTime(),
    );
  }

  static List<TrackedWorkoutModel> list({
    required int length,
    DateTime? startTimestamp,
  }) {
    return List.generate(length, (_) => single(startTimestamp: startTimestamp));
  }
}

class TrackedWorkoutEntityGenerator {
  static TrackedWorkoutEntity single({DateTime? startTimestamp}) {
    return TrackedWorkoutEntity(
      id: faker.randomGenerator.integer(9999),
      title: faker.person.name(),
      subtitle: faker.company.name(),
      notes: faker.lorem.sentences(5).join(' '),
      durationInMinutes: faker.randomGenerator.integer(99),
      startTimestamp: startTimestamp ?? faker.date.dateTime(),
      createdAt: faker.date.dateTime(),
      updatedAt: faker.date.dateTime(),
    );
  }

  static List<TrackedWorkoutEntity> list({
    required int length,
    DateTime? startTimestamp,
  }) {
    return List.generate(length, (_) => single(startTimestamp: startTimestamp));
  }
}

class WorkoutSectionModelGenerator {
  static WorkoutSectionModel single() {
    return WorkoutSectionModel(
      id: faker.randomGenerator.integer(9999),
      title: faker.company.name(),
    );
  }

  static List<WorkoutSectionModel> list({required int length}) {
    return List.generate(length, (_) => single());
  }
}

class WorkoutSectionEntityGenerator {
  static WorkoutSectionEntity single() {
    return WorkoutSectionEntity(
      id: faker.randomGenerator.integer(9999),
      title: faker.company.name(),
    );
  }

  static List<WorkoutSectionEntity> list({required int length}) {
    return List.generate(length, (_) => single());
  }
}

class SetOrganizerModelGenerator {
  static SetOrganizerModel single() {
    return SetOrganizerModel(
      id: faker.randomGenerator.integer(9999),
      setNumber: faker.randomGenerator.integer(99),
      organization: SetOrganizationEnum.values[
          faker.randomGenerator.integer(SetOrganizationEnum.values.length)],
    );
  }

  static List<SetOrganizerModel> list({required int length}) {
    return List.generate(length, (_) => single());
  }
}

class SetOrganizerEntityGenerator {
  static SetOrganizerEntity single() {
    return SetOrganizerEntity(
      id: faker.randomGenerator.integer(9999),
      setNumber: faker.randomGenerator.integer(99),
    );
  }

  static List<SetOrganizerEntity> list({required int length}) {
    return List.generate(length, (_) => single());
  }
}

class SetTypeModelGenerator {
  static SetTypeModel single() {
    return SetTypeModel(
      id: faker.randomGenerator.integer(9999),
      setLetter: faker.lorem.word(),
      type: SetTypeEnum
          .values[faker.randomGenerator.integer(SetTypeEnum.values.length)],
      exercise: ExerciseModelGenerator.single(),
    );
  }

  static List<SetTypeModel> list({required int length}) {
    return List.generate(length, (_) => single());
  }
}

class SetTypeEntityGenerator {
  static SetTypeEntity single() {
    return SetTypeEntity(
      id: faker.randomGenerator.integer(9999),
      setLetter: faker.lorem.word(),
    )..exercise.target = ExerciseEntityGenerator.single();
  }

  static List<SetTypeEntity> list({required int length}) {
    return List.generate(length, (_) => single());
  }
}

class NormalSetModelGenerator {
  static NormalSetModel single() {
    return NormalSetModel(
      id: faker.randomGenerator.integer(9999),
      reps: faker.randomGenerator.integer(99),
      load: faker.randomGenerator.decimal(),
      units: Units.values[faker.randomGenerator.integer(Units.values.length)],
    );
  }

  static List<NormalSetModel> list({required int length}) {
    return List.generate(length, (_) => single());
  }
}

class NormalSetEntityGenerator {
  static NormalSetEntity single() {
    return NormalSetEntity(
      id: faker.randomGenerator.integer(9999),
      reps: faker.randomGenerator.integer(99),
      load: faker.randomGenerator.decimal(),
    );
  }

  static List<NormalSetEntity> list({required int length}) {
    return List.generate(length, (_) => single());
  }
}
