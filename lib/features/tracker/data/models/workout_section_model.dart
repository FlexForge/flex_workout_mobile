import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/workout_section_entity.dart';
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

extension ConvertWorkoutSectionModel on WorkoutSectionModel {
  WorkoutSection toEntity() => WorkoutSection(
        title: title,
      )..organizers.addAll(organizers.map((e) => e.toEntity()).toList());
}

@freezed
class SetOrganizerModel with _$SetOrganizerModel {
  const factory SetOrganizerModel({
    required int id,
    required SetOrganizationEnum organization,
    required int setNumber,
    SetTypeModel? defaultSet,
    @Default([]) List<SetTypeModel> superSet,
  }) = _SetOrganizerModel;
}

extension ConvertSetOrganizerModel on SetOrganizerModel {
  SetOrganizer toEntity() => SetOrganizer()
    ..defaultSet.target = organization == SetOrganizationEnum.defaultSet
        ? defaultSet?.toEntity()
        : null
    ..superSet.addAll(superSet.map((e) => e.toEntity()).toList());
}

@freezed
class SetTypeModel with _$SetTypeModel {
  const factory SetTypeModel({
    required int id,
    required ExerciseModel exercise,
    required SetTypeEnum type,
    String? setLetter,
    NormalSetModel? normalSet,
  }) = _SetTypeModel;
}

extension ConvertSetTypeModel on SetTypeModel {
  SetType toEntity() => SetType()
    ..exercise.target = exercise.toEntity()
    ..normalSet.target =
        type == SetTypeEnum.normalSet ? normalSet?.toEntity() : null;
}

@freezed
class NormalSetModel with _$NormalSetModel {
  const factory NormalSetModel({
    required int id,
  }) = _NormalSetModel;
}

extension ConvertNormalSetModel on NormalSetModel {
  NormalSet toEntity() => NormalSet();
}
