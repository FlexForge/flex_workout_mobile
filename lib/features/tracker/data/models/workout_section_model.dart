import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_section_model.freezed.dart';

enum SetOrganizationEnum {
  defaultSet,
  superSet,
}

enum SetTypeEnum {
  normalSet,
}

@freezed
class WorkoutSectionModel with _$WorkoutSectionModel {
  const factory WorkoutSectionModel({
    required int id,
    required String title,
    @Default([]) List<SetOrganizerModel> organizers,
  }) = _WorkoutSectionModel;
}

@freezed
class SetOrganizerModel with _$SetOrganizerModel {
  const factory SetOrganizerModel({
    required int id,
    required SetOrganizationEnum organization,
    SetTypeModel? defaultSet,
    @Default([]) List<SetTypeModel> superSet,
  }) = _SetOrganizerModel;
}

@freezed
class SetTypeModel with _$SetTypeModel {
  const factory SetTypeModel({
    required int id,
    required ExerciseModel exercise,
    required SetTypeEnum type,
    NormalSetModel? normalSet,
  }) = _SetTypeModel;
}

@freezed
class NormalSetModel with _$NormalSetModel {
  const factory NormalSetModel({
    required int id,
  }) = _NormalSetModel;
}
