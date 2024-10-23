import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/core/extensions/date_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_controller.g.dart';
part 'timer_controller.mapper.dart';

@MappableClass()
class TimerModel with TimerModelMappable {
  TimerModel({
    required this.initialDuration,
    this.elapsed = Duration.zero,
    this.isActive = false,
    this.isPaused = false,
  });

  final Duration initialDuration;
  final Duration elapsed;
  final bool isPaused;
  final bool isActive;

  Duration get remainingTime => initialDuration - elapsed;

  String get formattedElapsed => elapsed.formatted;
  String get formattedInitial => initialDuration.formatted;
  String get formattedRemaining => remainingTime.formatted;
}

@Riverpod(keepAlive: true)
class TimerController extends _$TimerController {
  late Timer _timer;

  @override
  TimerModel build() {
    return TimerModel(initialDuration: Duration.zero);
  }

  void setTimer(Duration duration) {
    state = state.copyWith(initialDuration: duration);
  }

  void start() {
    state = state.copyWith(isActive: true, isPaused: false);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state =
          state.copyWith(elapsed: state.elapsed + const Duration(seconds: 1));

      if (state.elapsed >= state.initialDuration) cancel();
    });
  }

  void stop() {
    state = state.copyWith(isPaused: true);
    _timer.cancel();
  }

  void cancel() {
    state = state.copyWith(isActive: false, elapsed: Duration.zero);
    _timer.cancel();
  }

  void addTime() {
    state = state.copyWith(
      initialDuration: state.initialDuration + const Duration(seconds: 15),
    );
  }

  void removeTime() {
    state = state.copyWith(
      initialDuration: state.initialDuration - const Duration(seconds: 15),
    );
  }
}
