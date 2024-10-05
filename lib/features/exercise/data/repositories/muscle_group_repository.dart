import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart';
import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:fpdart/fpdart.dart';

class MuscleGroupRepository {
  MuscleGroupRepository({required this.store});

  final Store store;

  Box<MuscleGroupEntity> get box => store.box<MuscleGroupEntity>();

  Either<Failure, List<MuscleGroupModel>> getMuscleGroups() {
    try {
      final res = box.getAll();

      return right(res.map((e) => e.toModel()).toList());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }
}
