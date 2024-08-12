import 'package:flex_workout_mobile/app.dart';
import 'package:flex_workout_mobile/bootstrap.dart';
import 'package:flex_workout_mobile/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  F.appFlavor = Flavor.prod;

  runApp(
    UncontrolledProviderScope(
      container: await bootstrap(),
      child: const MainApp(),
    ),
  );
}
