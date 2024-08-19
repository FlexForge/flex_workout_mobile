import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tracked_workout_filter_controller.g.dart';

@riverpod
class TrackedWorkoutFilterController extends _$TrackedWorkoutFilterController {
  @override
  DateTime? build() {
    return null;
  }

  // ignore: use_setters_to_change_properties
  void handle(DateTime? filter) {
    state = filter;
  }
}
