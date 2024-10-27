import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/date_extensions.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/timer_controller.dart';
import 'package:flex_workout_mobile/features/tracker/data/models/timer_model.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/timer/painters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class WorkoutTimerWrapper extends ConsumerWidget {
  const WorkoutTimerWrapper({required this.controller, super.key});

  final AnimationController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerControllerProvider);

    return AlertDialog(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: context.colors.backgroundPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: AppLayout.p4),
      content: timer.isActive
          ? WorkoutTimer(controller: controller)
          : const SetWorkoutTimer(),
    );
  }
}

class SetWorkoutTimer extends ConsumerStatefulWidget {
  const SetWorkoutTimer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetWorkoutTimerState();
}

class _SetWorkoutTimerState extends ConsumerState<SetWorkoutTimer> {
  Duration duration = const Duration(seconds: 15);

  static const defaultTimes = [
    Duration(minutes: 1),
    Duration(minutes: 1, seconds: 30),
    Duration(minutes: 2),
    Duration(minutes: 2, seconds: 30),
    Duration(minutes: 3),
    Duration(minutes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: AppLayout.p4),
              ...defaultTimes.map(
                (time) => Padding(
                  padding: const EdgeInsets.only(right: AppLayout.p2),
                  child: FlexButton(
                    onPressed: () {
                      ref.read(timerControllerProvider.notifier).setTimer(time);
                      ref.read(timerControllerProvider.notifier).start();
                    },
                    label: time.formatted,
                    backgroundColor: context.colors.backgroundSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AppLayout.p2),
            ],
          ),
        ),
        const SizedBox(height: AppLayout.p2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          alignment: FractionalOffset.center,
          child: AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(AppLayout.p2),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(AppLayout.roundedRadius),
                ),
                width: double.infinity,
                child: CupertinoPicker.builder(
                  itemExtent: 44,
                  childCount: 40,
                  onSelectedItemChanged: (index) {
                    duration = Duration(seconds: (index + 1) * 15);
                  },
                  itemBuilder: (context, index) {
                    final duration = Duration(seconds: (index + 1) * 15);

                    return Center(
                      child: Text(
                        duration.formatted,
                        style: context.typography.labelLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          fontFeatures: [
                            const FontFeature.tabularFigures(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppLayout.p2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: FlexButton(
            onPressed: () {
              ref.read(timerControllerProvider.notifier).setTimer(duration);
              ref.read(timerControllerProvider.notifier).start();
            },
            expanded: true,
            label: 'Start',
            backgroundColor: context.colors.foregroundPrimary,
            foregroundColor: context.colors.backgroundPrimary,
          ),
        ),
      ],
    );
  }
}

class WorkoutTimer extends ConsumerStatefulWidget {
  const WorkoutTimer({
    required this.controller,
    super.key,
  });

  final AnimationController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends ConsumerState<WorkoutTimer>
    with TickerProviderStateMixin {
  void addTime(TimerModel timer) {
    final newDuration = timer.initialDuration + const Duration(seconds: 15);
    ref.read(timerControllerProvider.notifier).addTime();

    final newValue = timer.elapsed.inSeconds / newDuration.inSeconds;

    widget.controller
      ..duration = newDuration
      ..value = newValue;

    if (!timer.isPaused) {
      widget.controller.forward(from: newValue);
    }
  }

  void removeTime(TimerModel timer) {
    if (timer.remainingTime.inSeconds <= 15) return;

    final newDuration = timer.initialDuration - const Duration(seconds: 15);
    ref.read(timerControllerProvider.notifier).removeTime();

    final newValue = timer.elapsed.inSeconds / newDuration.inSeconds;

    widget.controller
      ..duration = newDuration
      ..value = newValue;

    if (!timer.isPaused) {
      widget.controller.forward(from: newValue);
    }
  }

  @override
  void initState() {
    super.initState();
    final timer = ref.read(timerControllerProvider);
    final currentValue =
        timer.elapsed.inSeconds / timer.initialDuration.inSeconds;

    widget.controller
      ..duration = timer.initialDuration
      ..value = currentValue;

    if (!timer.isPaused) {
      widget.controller.forward(from: widget.controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(timerControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: FractionalOffset.center,
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  alignment: FractionalOffset.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: CustomPaint(
                        painter: WorkoutTimerPainter(
                          animation: widget.controller,
                          ringColor: context.colors.backgroundSecondary,
                          fillColor: context.colors.blue,
                          strokeCap: StrokeCap.butt,
                          fillWidth: 4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppLayout.p2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colors.backgroundSecondary,
                          borderRadius:
                              BorderRadius.circular(AppLayout.roundedRadius),
                        ),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              timer.formattedRemaining,
                              style: context.typography.titleLarge.copyWith(
                                fontSize: 64,
                                fontWeight: FontWeight.w900,
                                fontFeatures: [
                                  const FontFeature.tabularFigures(),
                                ],
                              ),
                              textWidthBasis: TextWidthBasis.longestLine,
                            ),
                            Text(
                              timer.formattedInitial,
                              style: context.typography.titleSmall.copyWith(
                                fontWeight: FontWeight.w900,
                                height: 1,
                                color: context.colors.foregroundSecondary,
                              ),
                              textWidthBasis: TextWidthBasis.longestLine,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppLayout.p2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlexButton(
                  onPressed: () => addTime(timer),
                  label: '+ 15s',
                ),
                const SizedBox(width: AppLayout.p2),
                FlexButton(
                  onPressed: () {
                    if (!timer.isPaused) {
                      widget.controller.stop();
                      ref.read(timerControllerProvider.notifier).stop();
                    } else {
                      widget.controller.forward(from: widget.controller.value);
                      ref.read(timerControllerProvider.notifier).start();
                    }
                  },
                  iconSize: 24,
                  iconWeight: 700,
                  iconFill: 1,
                  icon: timer.isPaused ? Symbols.play_arrow : Symbols.pause,
                ),
                const SizedBox(width: AppLayout.p2),
                FlexButton(
                  onPressed: () =>
                      ref.read(timerControllerProvider.notifier).cancel(),
                  iconSize: 24,
                  iconWeight: 700,
                  iconFill: 1,
                  icon: Symbols.stop,
                ),
                const SizedBox(width: AppLayout.p2),
                FlexButton(
                  onPressed: () => removeTime(timer),
                  label: '- 15s',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
