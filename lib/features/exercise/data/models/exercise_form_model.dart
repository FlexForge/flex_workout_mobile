// ignore_for_file: inference_failure_on_instance_creation

import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/exercise/data/validators/youtube_url_validator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

part 'exercise_form_model.gform.dart';
part 'exercise_form_model.freezed.dart';

@Rf()
@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    General? general,
    Advanced? advanced,
    MuscleGroups? muscleGroups,
  }) = _Exercise;
}

@Rf()
@RfGroup()
@freezed
class General with _$General {
  const factory General({
    @RfControl(validators: [RequiredValidator()]) String? name,
    @RfControl() String? description,
    @RfControl(validators: [YoutubeUrlValidator()]) String? videoUrl,
  }) = _General;
}

@Rf()
@RfGroup()
@freezed
class Advanced with _$Advanced {
  const factory Advanced({
    @RfControl() Equipment? equipment,
    @RfControl() MovementPattern? movementPattern,
    @RfControl() Engagement? engagement,
  }) = _Advanced;
}

@Rf()
@RfGroup()
@freezed
class MuscleGroups with _$MuscleGroups {
  const factory MuscleGroups({
    @RfControl() List<MuscleGroupModel>? primaryMuscleGroups,
    @RfControl() List<MuscleGroupModel>? secondaryMuscleGroups,
  }) = _MuscleGroups;
}
