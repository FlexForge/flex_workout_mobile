import 'dart:async';

import 'package:flex_workout_mobile/features/tracker/data/models/timer_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_controller.g.dart';

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

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      state =
          state.copyWith(elapsed: state.elapsed + const Duration(seconds: 1));

      if (state.remainingTime.inSeconds <= 4) {
        await FlutterRingtonePlayer().play(
          android: AndroidSounds.alarm,
          ios: const IosSound(1306),
        );
        await HapticFeedback.heavyImpact();
      }

      if (state.elapsed >= state.initialDuration) {
        await FlutterRingtonePlayer().play(
          android: AndroidSounds.alarm,
          ios: IosSounds.alarm,
        );
        cancel();
      }
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
