import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracked_workout_model.freezed.dart';

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
    String? notes,
  }) = _TrackedWorkoutModel;
}

extension ConvertTrackedWorkoutModel on TrackedWorkoutModel {
  TrackedWorkout toEntity() => TrackedWorkout(
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
