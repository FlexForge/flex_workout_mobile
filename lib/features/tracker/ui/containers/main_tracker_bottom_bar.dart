import 'dart:math' as math;

import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainTrackerBottomBar extends StatefulWidget {
  const MainTrackerBottomBar({required this.next, super.key});

  final VoidCallback next;

  @override
  State<MainTrackerBottomBar> createState() => _MainTrackerBottomBarState();
}

class _MainTrackerBottomBarState extends State<MainTrackerBottomBar>
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
                FlexButton(
                  onPressed: () {
                    controller
                      ..duration = const Duration(seconds: 10)
                      ..forward();
                    // showDialog<void>(
                    //   context: context,
                    //   builder: (context) => const WorkoutTimer(
                    //     startDuration: Duration(seconds: 30),
                    //     initialDuration: Duration(minutes: 2, seconds: 30),
                    //   ),
                    // ),
                  },
                  label: 'Timer',
                  icon: Symbols.timer,
                  backgroundColor: context.colors.backgroundSecondary,
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
    required this.startDuration,
    required this.initialDuration,
    super.key,
  });

  final Duration startDuration;
  final Duration initialDuration;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends ConsumerState<WorkoutTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Duration duration;

  String formatTime(Duration duration) => '${duration.inMinutes}'
      ':'
      '${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

  String get timerString {
    final duration = controller.duration! * (1 - controller.value);
    return formatTime(duration);
  }

  @override
  void initState() {
    super.initState();
    duration = widget.initialDuration;
    controller = AnimationController(
      vsync: this,
      duration: widget.initialDuration,
    );
    controller.forward(
      from: widget.startDuration.inMilliseconds /
          widget.initialDuration.inMilliseconds,
    );
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: context.colors.backgroundPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
      ),
      content: AnimatedBuilder(
        animation: controller,
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
                          animation: controller,
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
                              timerString,
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
                              formatTime(duration),
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
              animation: controller,
              builder: (context, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlexButton(
                    onPressed: () {
                      final oldValue =
                          duration.inMilliseconds * controller.value;
                      duration = duration + const Duration(seconds: 15);
                      final newValue = oldValue / duration.inMilliseconds;

                      controller
                        ..duration = duration
                        ..value = newValue
                        ..forward(from: controller.value);
                    },
                    label: '+ 15s',
                  ),
                  const SizedBox(width: AppLayout.p2),
                  FlexButton(
                    onPressed: () {
                      if (controller.isAnimating) {
                        controller.stop();
                        setState(() {});
                      } else {
                        controller.forward(from: controller.value);
                        setState(() {});
                      }
                    },
                    iconSize: 24,
                    iconWeight: 700,
                    iconFill: 1,
                    icon: controller.isAnimating
                        ? Symbols.pause
                        : Symbols.play_arrow,
                  ),
                  const SizedBox(width: AppLayout.p2),
                  FlexButton(
                    onPressed: () {
                      if (duration.inSeconds <= 15) return;

                      final oldValue =
                          duration.inMilliseconds * controller.value;
                      duration = duration - const Duration(seconds: 15);
                      final newValue = oldValue / duration.inMilliseconds;

                      controller
                        ..duration = duration
                        ..value = newValue
                        ..forward(from: controller.value);
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
