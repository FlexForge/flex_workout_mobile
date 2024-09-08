import 'package:flex_workout_mobile/features/tracker/data/db/tracked_workout_entity.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_section_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

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
    @Default([]) List<WorkoutSectionModel> sections,
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

extension Date on DateTime {
  String toReadableDate() => DateFormat.yMMMMd().format(this);

  String toReadableTime() =>
      DateFormat.jm().format(this).toLowerCase().replaceAll(' ', '');
}
