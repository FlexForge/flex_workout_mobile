// ignore_for_file: inference_failure_on_instance_creation
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'workout_form_model.gform.dart';
part 'workout_form_model.freezed.dart';

@Rf()
@freezed
class Workout with _$Workout {
  const factory Workout({
    General? general,
  }) = _Workout;
}

@Rf()
@RfGroup()
@freezed
class General with _$General {
  const factory General({
    @RfControl(validators: [RequiredValidator()]) String? name,
    @RfControl(validators: [RequiredValidator()]) String? focus,
    // TODO: Program
    @RfControl() String? description,
  }) = _General;
}
