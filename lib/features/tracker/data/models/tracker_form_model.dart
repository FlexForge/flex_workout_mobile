// ignore_for_file: inference_failure_on_instance_creation

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
  }) = _Tracker;
}

extension Date on DateTime {
  String toReadableDate() => DateFormat.yMMMMd().format(this);

  String toReadableTime() =>
      DateFormat.jm().format(this).toLowerCase().replaceAll(' ', '');
}
