import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'tracked_workout_model.freezed.dart';

enum SetOrganizationEnum {
  defaultSet,
  superSet,
}

enum SetTypeEnum {
  normalSet,
}

@freezed
class TrackedWorkoutModel with _$TrackedWorkoutModel {
  const factory TrackedWorkoutModel({
    required int id,
    required String title,
    required String subtitle,
    required int durationInMinutes,
    required DateTime startTimestamp,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<WorkoutSectionModel> sections,
    String? notes,
  }) = _TrackedWorkoutModel;
}

extension ConvertTrackedWorkoutModel on TrackedWorkoutModel {
  TrackedWorkoutEntity toEntity() => TrackedWorkoutEntity(
        id: id,
        title: title,
        subtitle: subtitle,
        notes: notes,
        durationInMinutes: durationInMinutes,
        startTimestamp: startTimestamp,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
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
  WorkoutSectionEntity toEntity() => WorkoutSectionEntity(
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
  SetOrganizerEntity toEntity() => SetOrganizerEntity(
        setNumber: setNumber,
      )
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
  SetTypeEntity toEntity() => SetTypeEntity(
        setLetter: setLetter,
      )
        ..exercise.target = exercise.toEntity()
        ..normalSet.target =
            type == SetTypeEnum.normalSet ? normalSet?.toEntity() : null;
}

@freezed
class NormalSetModel with _$NormalSetModel {
  const factory NormalSetModel({
    required int id,
    required int reps,
    required double load,
    required Units units,
  }) = _NormalSetModel;
}

extension ConvertNormalSetModel on NormalSetModel {
  NormalSetEntity toEntity() => NormalSetEntity(
        reps: reps,
        load: load,
        units: units,
      );
}

extension Date on DateTime {
  String toReadableDate() => DateFormat.yMMMMd().format(this);

  String toReadableTime() =>
      DateFormat.jm().format(this).toLowerCase().replaceAll(' ', '');
}
