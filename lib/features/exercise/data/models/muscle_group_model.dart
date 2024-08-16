import 'package:flex_workout_mobile/features/exercise/data/db/muscle_group_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'muscle_group_model.freezed.dart';

@freezed
class MuscleGroupModel with _$MuscleGroupModel {
  const factory MuscleGroupModel({
    required int id,
    required String name,
    required List<String> diagramPathNames,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MuscleGroupModel;
}

extension ConvertMuscleGroupModel on MuscleGroupModel {
  MuscleGroup toEntity() => MuscleGroup(
        id: id,
        name: name,
        diagramPathNames: diagramPathNames,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
}
