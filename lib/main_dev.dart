import 'package:flex_workout_mobile/app.dart';
import 'package:flex_workout_mobile/bootstrap.dart';
import 'package:flex_workout_mobile/flavors.dart';
import 'package:flex_workout_mobile/platforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  F.appFlavor = Flavor.dev;

  P();

  runApp(
    UncontrolledProviderScope(
      container: await bootstrap(),
      child: const MainApp(),
    ),
  );
}
