// ignore_for_file: inference_failure_on_instance_creation

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'tracker_form_model.gform.dart';
part 'tracker_form_model.freezed.dart';

@Rf()
@freezed
class MainTrackerInfo with _$MainTrackerInfo {
  const factory MainTrackerInfo({
    @RfControl() String? title,
    @RfControl() String? notes,
  }) = _MainTrackerInfo;
}
