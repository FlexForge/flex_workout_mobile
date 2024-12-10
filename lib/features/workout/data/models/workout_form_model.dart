// ignore_for_file: inference_failure_on_instance_creation

import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/workout/data/models/workout_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'workout_form_model.gform.dart';
part 'workout_form_model.freezed.dart';

@Rf()
@freezed
class Workout with _$Workout {
  const factory Workout({
    General? general,
    Exercises? exercises,
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

@Rf()
@RfGroup()
@freezed
class Exercises with _$Exercises {
  const factory Exercises({
    @RfControl() List<IWorkoutSection>? sections,
    @RfControl() List<MuscleGroupModel>? primaryMuscleGroups,
    @RfControl() List<MuscleGroupModel>? secondaryMuscleGroups,
  }) = _Exercises;
}
