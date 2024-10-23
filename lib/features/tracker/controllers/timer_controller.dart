import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_controller.g.dart';
part 'timer_controller.mapper.dart';

@MappableClass()
class TimerModel with TimerModelMappable {
  TimerModel({
    required this.initialDuration,
    this.elapsed = Duration.zero,
    this.isActive = false,
  });

  final Duration initialDuration;
  final Duration elapsed;
  final bool isActive;

  String formatTime(Duration duration) => '${duration.inMinutes}'
      ':'
      '${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

  Duration get remainingTime => initialDuration - elapsed;

  String get formattedElapsed => formatTime(elapsed);
  String get formattedInitial => formatTime(initialDuration);
  String get formattedRemaining => formatTime(remainingTime);
}

@riverpod
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
    state = state.copyWith(isActive: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state =
          state.copyWith(elapsed: state.elapsed + const Duration(seconds: 1));

      if (state.elapsed >= state.initialDuration) {
        state = state.copyWith(isActive: false, elapsed: Duration.zero);
        timer.cancel();
      }
    });
  }

  void stop() {
    state = state.copyWith(isActive: false);
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
