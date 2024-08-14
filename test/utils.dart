import 'package:flex_workout_mobile/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}

class WidgetWrapper extends StatelessWidget {
  const WidgetWrapper({this.child, this.function, super.key});

  final Widget? child;
  final void Function(BuildContext)? function;

  @override
  Widget build(BuildContext context) {
    if (function != null) {
      Future.delayed(Duration.zero, () => function!(context));
    }
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      home: Scaffold(
        body: child,
      ),
    );
  }
}
