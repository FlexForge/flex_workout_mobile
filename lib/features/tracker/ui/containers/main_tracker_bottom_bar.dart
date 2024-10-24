import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/controllers/timer_controller.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/timer/painters.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/timer/timer.dart';
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
    final timer = ref.read(timerControllerProvider);

    if (timer.isActive) {
      controller
        ..duration = timer.initialDuration
        ..forward(
          from: timer.elapsed.inSeconds / timer.initialDuration.inSeconds,
        );
    }
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
                    onPressed: () {
                      widget.next.call();
                      ref.invalidate(timerControllerProvider);
                      controller.stop();
                    },
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
