import 'package:dart_mappable/dart_mappable.dart';
import 'package:flex_workout_mobile/core/extensions/date_extensions.dart';

part 'timer_model.mapper.dart';

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
