import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracked_workout_model.dart';

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
