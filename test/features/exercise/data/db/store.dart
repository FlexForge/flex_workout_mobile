import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';

///
/// Hardcoded Data
///

final exampleExerciseOne = ExerciseModel(
  id: 1,
  name: 'Example Exercise 1',
  description: 'Example Description 1',
  videoUrl: 'https://www.youtube.com/',
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.horizontalPull,
  engagement: Engagement.bilateral,
  primaryMuscleGroups: [],
  secondaryMuscleGroups: [],
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);

final exampleExerciseTwo = ExerciseModel(
  id: 2,
  name: 'Example Exercise 2',
  description: 'Example Description 2',
  videoUrl: 'https://www.youtube.com/',
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.horizontalPull,
  engagement: Engagement.bilateral,
  primaryMuscleGroups: [],
  secondaryMuscleGroups: [],
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);

final exampleExerciseThree = ExerciseModel(
  id: 3,
  name: 'Example Exercise 3',
  description: 'Example Description 3',
  videoUrl: 'https://www.youtube.com/',
  equipment: Equipment.barbell,
  movementPattern: MovementPattern.horizontalPull,
  engagement: Engagement.bilateral,
  primaryMuscleGroups: [],
  secondaryMuscleGroups: [],
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);

///
/// Random Generators
///

ExerciseModel generateRandomExercise() {
  return ExerciseModel(
    id: faker.randomGenerator.integer(9999999),
    name: faker.lorem.words(faker.randomGenerator.integer(5, min: 1)).join(' '),
    description: faker.lorem.sentences(5).toString(),
    videoUrl: faker.internet.httpsUrl(),
    equipment: Equipment
        .values[faker.randomGenerator.integer(Equipment.values.length - 1)],
    movementPattern: MovementPattern.values[
        faker.randomGenerator.integer(MovementPattern.values.length - 1)],
    engagement: Engagement
        .values[faker.randomGenerator.integer(Engagement.values.length - 1)],
    primaryMuscleGroups: [],
    secondaryMuscleGroups: [],
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  );
}

List<ExerciseModel> generateRandomExercises(int count) {
  return List.generate(count, (index) => generateRandomExercise());
}
