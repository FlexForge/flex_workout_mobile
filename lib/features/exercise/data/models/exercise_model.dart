import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_model.freezed.dart';

@freezed
class ExerciseModel with _$ExerciseModel {
  const factory ExerciseModel({
    required int id,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? description,
    String? videoUrl,
  }) = _ExerciseModel;
}
