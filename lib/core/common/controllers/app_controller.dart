import 'package:flex_workout_mobile/core/common/data/models/app_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_controller.g.dart';

@Riverpod(keepAlive: true)
class AppController extends _$AppController {
  @override
  AppModel build() {
    return const AppModel();
  }

  void startWorkout() {
    state = state.copyWith(workoutInProgress: true);
  }

  void endWorkout() {
    state = state.copyWith(workoutInProgress: false);
  }
}
