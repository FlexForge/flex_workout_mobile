import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/tracker_form_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_tracker_info_controller.g.dart';

class WorkoutSummaryTableCell {
  WorkoutSummaryTableCell(
    this.exercise, {
    this.superSetIndex,
  });

  final ExerciseModel exercise;
  final int? superSetIndex;
}

@Riverpod(keepAlive: true)
class MainTrackerInfoFormController extends _$MainTrackerInfoFormController {
  @override
  MainTrackerInfoForm build() {
    return MainTrackerInfoForm(
      MainTrackerInfoForm.formElements(const MainTrackerInfo()),
      null,
    );
  }
}
