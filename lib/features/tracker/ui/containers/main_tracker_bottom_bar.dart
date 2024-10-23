import 'dart:math' as math;

import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/timer_controller.dart';
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
                      const duration = Duration(seconds: 30);
                      ref
                          .read(timerControllerProvider.notifier)
                          .setTimer(duration);

                      controller.duration = duration;

                      showDialog<void>(
                        context: context,
                        builder: (context) => WorkoutTimer(
                          initialDuration: duration,
                          controller: controller,
                        ),
                      );
                    },
                    // label: timer.formattedRemaining,
                    label: timer.elapsed > Duration.zero
                        ? timer.formattedRemaining
                        : 'Timer',
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

class WorkoutTimer extends ConsumerStatefulWidget {
  const WorkoutTimer({
    required this.initialDuration,
    required this.controller,
    this.startDuration = Duration.zero,
    super.key,
  });

  final Duration startDuration;
  final Duration initialDuration;
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
    widget.controller.value = currentValue;

    if (timer.isActive) {
      widget.controller.forward(from: widget.controller.value);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(timerControllerProvider);

    return AlertDialog(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: context.colors.backgroundPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
      ),
      content: AnimatedBuilder(
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
                      ref.read(timerControllerProvider.notifier).addTime();
                      final newValue = timer.elapsed.inSeconds /
                          timer.initialDuration.inSeconds;

                      widget.controller
                        ..duration =
                            timer.initialDuration + const Duration(seconds: 15)
                        ..value = newValue
                        ..forward(from: widget.controller.value);
                    },
                    label: '+ 15s',
                  ),
                  const SizedBox(width: AppLayout.p2),
                  FlexButton(
                    onPressed: () {
                      if (timer.isActive) {
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
                    icon: timer.isActive ? Symbols.pause : Symbols.play_arrow,
                  ),
                  const SizedBox(width: AppLayout.p2),
                  FlexButton(
                    onPressed: () {
                      if (duration.inSeconds <= 15) return;

                      final oldValue =
                          duration.inMilliseconds * widget.controller.value;
                      duration = duration - const Duration(seconds: 15);
                      final newValue = oldValue / duration.inMilliseconds;

                      widget.controller
                        ..duration = duration
                        ..value = newValue
                        ..forward(from: widget.controller.value);
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
