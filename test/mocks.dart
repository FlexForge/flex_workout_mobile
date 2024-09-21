import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/auth/data/repositories/onboarding_repository.dart';
import 'package:flex_workout_mobile/features/auth/data/repositories/user_repository.dart';
import 'package:flex_workout_mobile/features/exercise/data/repositories/exercise_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockObjectBoxStore extends Mock implements Store {}

class MockExerciseRepository extends Mock implements ExerciseRepository {}
