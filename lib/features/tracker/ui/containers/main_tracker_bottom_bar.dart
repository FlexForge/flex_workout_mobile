import 'dart:math' as math;

import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/date_extensions.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/timer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainTrackerBottomBar extends ConsumerStatefulWidget {
  const MainTrackerBottomBar({required this.next, super.key});

  final VoidCallback next;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainTrackerBottomBarState();
}

class _MainTrackerBottomBarState extends ConsumerState<MainTrackerBottomBar>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(timerControllerProvider);

    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colors.divider), // Top border
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (timer.isActive)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                painter: WorkoutLineTimerPainter(
                  animation: controller,
                  lineColor: Colors.transparent,
                  fillColor: context.colors.blue,
                  strokeCap: StrokeCap.butt,
                  fillWidth: 4,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 92,
                  child: FlexButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (context) =>
                            WorkoutTimerWrapper(controller: controller),
                      );
                    },
                    // label: timer.formattedRemaining,
                    label: timer.isActive ? timer.formattedRemaining : 'Timer',
                    labelStyle: context.typography.labelLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFeatures: [
                        const FontFeature.tabularFigures(),
                      ],
                    ),
                    icon: Symbols.timer,
                    backgroundColor: context.colors.backgroundSecondary,
                  ),
                ),
                const SizedBox(width: AppLayout.p2),
                Expanded(
                  child: FlexButton(
                    onPressed: widget.next,
                    label: 'Finish',
                    icon: Symbols.check,
                    backgroundColor: context.colors.foregroundPrimary,
                    foregroundColor: context.colors.backgroundPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    void startTime() {
      ref.read(timerControllerProvider.notifier).setTimer(duration);
      ref.read(timerControllerProvider.notifier).start();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: AppLayout.p4),
              FlexButton(
                onPressed: () {},
                label: '1:00',
                backgroundColor: context.colors.backgroundSecondary,
              ),
              const SizedBox(width: AppLayout.p2),
              FlexButton(
                onPressed: () {},
                label: '1:30',
                backgroundColor: context.colors.backgroundSecondary,
              ),
              const SizedBox(width: AppLayout.p2),
              FlexButton(
                onPressed: () {},
                label: '2:00',
                backgroundColor: context.colors.backgroundSecondary,
              ),
              const SizedBox(width: AppLayout.p2),
              FlexButton(
                onPressed: () {},
                label: '2:30',
                backgroundColor: context.colors.backgroundSecondary,
              ),
              const SizedBox(width: AppLayout.p2),
              FlexButton(
                onPressed: () {},
                label: '3:00',
                backgroundColor: context.colors.backgroundSecondary,
              ),
              const SizedBox(width: AppLayout.p2),
              FlexButton(
                onPressed: () {},
                label: '5:00',
                backgroundColor: context.colors.backgroundSecondary,
              ),
              const SizedBox(width: AppLayout.p4),
            ],
          ),
        ),
        const SizedBox(height: AppLayout.p2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          alignment: FractionalOffset.center,
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              alignment: FractionalOffset.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(AppLayout.p2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.backgroundSecondary,
                      borderRadius:
                          BorderRadius.circular(AppLayout.roundedRadius),
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
              ],
            ),
          ),
        ),
        const SizedBox(height: AppLayout.p2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: FlexButton(
            onPressed: startTime,
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
  late Duration duration;

  @override
  void initState() {
    super.initState();
    final timer = ref.read(timerControllerProvider);
    final currentValue =
        timer.elapsed.inSeconds / timer.initialDuration.inSeconds;

    duration = timer.initialDuration;
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
            AnimatedBuilder(
              animation: widget.controller,
              builder: (context, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlexButton(
                    onPressed: () {
                      final newDuration =
                          timer.initialDuration + const Duration(seconds: 15);
                      ref.read(timerControllerProvider.notifier).addTime();

                      final newValue =
                          timer.elapsed.inSeconds / newDuration.inSeconds;

                      widget.controller
                        ..duration = newDuration
                        ..value = newValue;

                      if (!timer.isPaused) {
                        widget.controller.forward(from: newValue);
                      }
                    },
                    label: '+ 15s',
                  ),
                  const SizedBox(width: AppLayout.p2),
                  FlexButton(
                    onPressed: () {
                      if (!timer.isPaused) {
                        widget.controller.stop();
                        ref.read(timerControllerProvider.notifier).stop();
                      } else {
                        widget.controller
                            .forward(from: widget.controller.value);
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
                    onPressed: () {
                      ref.read(timerControllerProvider.notifier).cancel();
                    },
                    iconSize: 24,
                    iconWeight: 700,
                    iconFill: 1,
                    icon: Symbols.stop,
                  ),
                  const SizedBox(width: AppLayout.p2),
                  FlexButton(
                    onPressed: () {
                      if (timer.remainingTime.inSeconds <= 15) return;

                      final newDuration =
                          timer.initialDuration - const Duration(seconds: 15);
                      ref.read(timerControllerProvider.notifier).removeTime();

                      final newValue =
                          timer.elapsed.inSeconds / newDuration.inSeconds;

                      widget.controller
                        ..duration = newDuration
                        ..value = newValue;

                      if (!timer.isPaused) {
                        widget.controller.forward(from: newValue);
                      }
                    },
                    label: '- 15s',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutTimerPainter extends CustomPainter {
  WorkoutTimerPainter({
    required this.animation,
    required this.fillColor,
    required this.ringColor,
    this.fillWidth = 2.0,
    this.ringWidth = 2.0,
    this.strokeCap = StrokeCap.round,
  }) : super(repaint: animation);

  final Animation<double> animation;

  final Color ringColor;
  final Color fillColor;

  final double fillWidth;
  final double ringWidth;
  final StrokeCap strokeCap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ringColor
      ..strokeWidth = ringWidth
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    final progress = animation.value * 2 * math.pi;
    const startAngle = math.pi * 1.5;

    paint
      ..color = fillColor
      ..strokeWidth = fillWidth;
    canvas.drawArc(Offset.zero & size, startAngle, progress, false, paint);
  }

  @override
  bool shouldRepaint(WorkoutTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        ringColor != oldDelegate.ringColor ||
        fillColor != oldDelegate.fillColor;
  }
}

class WorkoutLineTimerPainter extends CustomPainter {
  WorkoutLineTimerPainter({
    required this.animation,
    required this.fillColor,
    required this.lineColor,
    this.fillWidth = 2.0,
    this.lineWidth = 2.0,
    this.strokeCap = StrokeCap.round,
  }) : super(repaint: animation);

  final Animation<double> animation;

  final Color lineColor;
  final Color fillColor;

  final double fillWidth;
  final double lineWidth;
  final StrokeCap strokeCap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset.zero,
      Offset(size.width, 0),
      paint,
    );

    paint
      ..color = fillColor
      ..strokeWidth = fillWidth;
    canvas.drawLine(
      Offset.zero,
      Offset(size.width - (size.width * animation.value), 0),
      paint,
    );
  }

  @override
  bool shouldRepaint(WorkoutLineTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        lineColor != oldDelegate.lineColor ||
        fillColor != oldDelegate.fillColor;
  }
}
