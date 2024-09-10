import 'package:flex_workout_mobile/features/tracker/data/models/current_workout_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_workout_controller.g.dart';

@Riverpod(keepAlive: true)
class LiveWorkoutController extends _$CurrentWorkoutController {
  @override
  LiveWorkoutModel build() {
    final now = DateTime.now();

    var time = 'Evening';
    if (now.hour > 17) time = 'Afternoon';
    if (now.hour > 11) time = 'Morning';

    return LiveWorkoutModel(subtitle: '$time Workout', startTimestamp: now);
  }
}
