import 'package:flex_workout_mobile/core/config/router.dart';
import 'package:flex_workout_mobile/core/theme/theme.dart';
import 'package:flex_workout_mobile/features/system/controllers/theme_controller.dart';
import 'package:flex_workout_mobile/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: F.title,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: theme,
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
