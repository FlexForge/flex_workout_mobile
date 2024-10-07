import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/exercise_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:fpdart/fpdart.dart';

class ExerciseRepository {
  ExerciseRepository({required this.store});
  final Store store;

  Box<ExerciseEntity> get box => store.box<ExerciseEntity>();

  Either<Failure, List<ExerciseModel>> getExercises({
    String query = '',
    List<int> muscleGroupQuery = const [],
    List<int> equipmentQuery = const [],
  }) {
    try {
      var searchQueryBuilder =
          ExerciseEntity_.name.contains(query, caseSensitive: false);

      if (equipmentQuery.isNotEmpty) {
        searchQueryBuilder = searchQueryBuilder.and(
          ExerciseEntity_.dbEquipment.oneOf(equipmentQuery),
        );
      }

      final searchBuilder = box.query(searchQueryBuilder);

      if (muscleGroupQuery.isNotEmpty) {
        searchBuilder.linkMany(
          ExerciseEntity_.primaryMuscleGroups,
          MuscleGroupEntity_.id.oneOf(muscleGroupQuery),
        );
      }

      final searchQuery = searchBuilder.build();

      final res = searchQuery.find();
      return right(res.map((e) => e.toModel()).toList());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }

  Either<Failure, ExerciseModel> getExerciseById(int id) {
    try {
      final res = box.get(id);

      if (res == null) {
        return left(
          const Failure.unprocessableEntity(message: 'Exercise does not exist'),
        );
      }

      return right(res.toModel());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }

  Either<Failure, ExerciseModel> createExercise({
    required String name,
    required List<MuscleGroupModel> primaryMuscleGroups,
    required List<MuscleGroupModel> secondaryMuscleGroups,
    Engagement? engagement,
    Equipment? equipment,
    MovementPattern? movementPattern,
    String? description,
    String? videoUrl,
  }) {
    try {
      final now = DateTime.now();

      final exerciseToAdd = ExerciseEntity(
        name: name,
        description: description,
        videoUrl: videoUrl,
        engagement: engagement ?? Engagement.bilateral,
        equipment: equipment ?? Equipment.other,
        movementPattern: movementPattern ?? MovementPattern.other,
        updatedAt: now,
        createdAt: now,
      )
        ..primaryMuscleGroups.addAll(primaryMuscleGroups.toEntity())
        ..secondaryMuscleGroups.addAll(secondaryMuscleGroups.toEntity());

      final id = box.put(exerciseToAdd);
      final res = box.get(id);

      if (res == null) {
        return left(
          const Failure.internalServerError(
            message: 'Unable to fetch new exercise',
          ),
        );
      }

      return right(res.toModel());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }
}
