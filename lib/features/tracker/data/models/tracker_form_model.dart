// ignore_for_file: inference_failure_on_instance_creation

import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/workout_section_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'tracker_form_model.gform.dart';
part 'tracker_form_model.freezed.dart';

@Rf()
@freezed
class Tracker with _$Tracker {
  const factory Tracker({
    @RfControl() String? title,
    @RfControl() String? subtitle,
    @RfControl() String? notes,
    @RfControl() DateTime? startTimestamp,
    @RfControl() DateTime? endTimestamp,
    @Default([]) @RfArray() List<TrackedWorkoutSection> sections,
  }) = _Tracker;
}

@Rf()
@RfGroup()
@freezed
class TrackedWorkoutSection with _$TrackedWorkoutSection {
  const factory TrackedWorkoutSection({
    required String title,
    @RfArray() @Default([]) List<TrackedSetOrganizer> organizers,
  }) = _TrackedWorkoutSection;
}

@RfGroup()
@freezed
class TrackedSetOrganizer with _$TrackedSetOrganizer {
  const factory TrackedSetOrganizer({
    required int setNumber,
    required SetOrganizationEnum organization,
    TrackedSetType? defaultSet,
    @RfArray() @Default([]) List<TrackedSetType> superSet,
  }) = _TrackedSetOrganizer;
}

@RfGroup()
@freezed
class TrackedSetType with _$TrackedSetType {
  const factory TrackedSetType({
    required SetTypeEnum type,
    required ExerciseModel exercise,
  }) = _TrackedSetType;
}

extension Date on DateTime {
  String toReadableDate() => DateFormat.yMMMMd().format(this);

  String toReadableTime() =>
      DateFormat.jm().format(this).toLowerCase().replaceAll(' ', '');
}
