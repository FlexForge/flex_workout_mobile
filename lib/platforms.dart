import 'dart:io' show Platform;
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/tracker/ui/screens/tracker_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

enum Platforms {
  ios,
  android,
}

class P {
  /// Constructor
  P() {
    if (Platform.isIOS) {
      appPlatform = Platforms.ios;
      trackerScreenPageBuilder = (context, state) => CupertinoModalSheetPage(
            swipeDismissible: true,
            barrierColor: context.colors.overlay,
            child: const TrackerScreenModal(nestedNavigator: TrackerScreen()),
          );
    } else if (Platform.isAndroid) {
      appPlatform = Platforms.android;
      trackerScreenPageBuilder = (context, state) => ModalSheetPage(
            swipeDismissible: true,
            barrierColor: context.colors.overlay,
            child: const TrackerScreenModal(nestedNavigator: TrackerScreen()),
          );
    } else {
      appPlatform = Platforms.ios;
      trackerScreenPageBuilder = (context, state) => CupertinoModalSheetPage(
            swipeDismissible: true,
            barrierColor: context.colors.overlay,
            child: const TrackerScreenModal(nestedNavigator: TrackerScreen()),
          );
    }
  }

  /// App Platform Type
  static Platforms? appPlatform;

  /// Widgets
  /// - Page Builders
  static Page<dynamic> Function(BuildContext, GoRouterState)?
      trackerScreenPageBuilder;
}
