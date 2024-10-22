import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/live_workout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'dart:math' as math;

class MainTrackerBottomBar extends ConsumerWidget {
  const MainTrackerBottomBar({required this.next, super.key});

  final VoidCallback next;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colors.divider), // Top border
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlexButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => WorkoutTimer(),
              ),
              label: 'Timer',
              icon: Symbols.timer,
              backgroundColor: context.colors.backgroundSecondary,
            ),
            const SizedBox(width: AppLayout.p2),
            Expanded(
              child: FlexButton(
                onPressed: next,
                label: 'Finish',
                icon: Symbols.check,
                backgroundColor: context.colors.foregroundPrimary,
                foregroundColor: context.colors.backgroundPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutTimer extends ConsumerStatefulWidget {
  const WorkoutTimer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends ConsumerState<WorkoutTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;

  String get timerString {
    final duration = controller.duration! * (1 - controller.value);
    return '${duration.inMinutes}'
        ':'
        '${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 2, seconds: 5),
    );
    controller.forward();
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
                              '2:30',
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
                      controller
                        ..duration =
                            controller.duration! + const Duration(seconds: 15)
                        ..forward(from: controller.value);
                    },
                    label: '+ 15s',
                  ),
                  const SizedBox(width: AppLayout.p2),
                  FlexButton(
                    onPressed: () {
                      if (controller.isAnimating) {
                        controller.stop();
                      } else {
                        controller.forward(from: controller.value);
                      }
                    },
                    iconSize: 24,
                    iconWeight: 700,
                    icon: controller.isAnimating
                        ? Symbols.pause
                        : Symbols.play_arrow,
                  ),
                  const SizedBox(width: AppLayout.p2),
                  FlexButton(
                    onPressed: () {
                      controller
                        ..duration =
                            controller.duration! - const Duration(seconds: 15)
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
