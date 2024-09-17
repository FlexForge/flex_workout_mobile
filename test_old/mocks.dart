import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/auth/data/repositories/onboarding_repository.dart';
import 'package:flex_workout_mobile/features/auth/data/repositories/user_repository.dart';
import 'package:flex_workout_mobile/features/exercise/data/repositories/exercise_repository.dart';
import 'package:flex_workout_mobile/features/tracker/data/repositories/tracked_workout_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockExerciseRepository extends Mock implements ExerciseRepository {}

class MockTrackedWorkoutRepository extends Mock
    implements TrackedWorkoutRepository {}

class MockObjectBoxStore extends Mock implements Store {}