import 'dart:io' show Platform;

import 'package:flex_workout_mobile/platforms.dart';
import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class FlexModalSheetPage<T> extends Page<T> {
  FlexModalSheetPage({
    required this.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    this.maintainState = true,
    this.barrierDismissible = true,
    this.swipeDismissible = false,
    this.fullscreenDialog = false,
    this.barrierLabel,
    this.barrierColor = Colors.black54,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionCurve = Curves.fastEaseInToSlowEaseOut,
    this.swipeDismissSensitivity = const SwipeDismissSensitivity(),
  });

  final Widget child;
  final bool maintainState;
  final bool fullscreenDialog;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool swipeDismissible;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final SwipeDismissSensitivity swipeDismissSensitivity;

  final p = P();

  RouteSettings getModalSheetPage() {
    if (Platform.isIOS) {
      return CupertinoModalSheetPage<T>(
        child: child,
        name: name,
        arguments: arguments,
        restorationId: restorationId,
        maintainState: maintainState,
        barrierDismissible: barrierDismissible,
        swipeDismissible: swipeDismissible,
        fullscreenDialog: fullscreenDialog,
        barrierLabel: barrierLabel,
        barrierColor: barrierColor,
        transitionDuration: transitionDuration,
        transitionCurve: transitionCurve,
        swipeDismissSensitivity: swipeDismissSensitivity,
      );
    } else {
      return ModalSheetPage(
        child: child,
        name: name,
        arguments: arguments,
        restorationId: restorationId,
        maintainState: maintainState,
        barrierDismissible: barrierDismissible,
        swipeDismissible: swipeDismissible,
        fullscreenDialog: fullscreenDialog,
        barrierLabel: barrierLabel,
        barrierColor: barrierColor,
        transitionDuration: transitionDuration,
        transitionCurve: transitionCurve,
        swipeDismissSensitivity: swipeDismissSensitivity,
      );
    }
  }

  @override
  Route<T> createRoute(BuildContext context) {
    // TODO: implement createRoute
    throw UnimplementedError();
  }
}
