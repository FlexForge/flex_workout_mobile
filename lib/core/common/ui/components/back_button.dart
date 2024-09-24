import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class FlexBackButton extends StatelessWidget {
  const FlexBackButton({this.icon = Symbols.arrow_back_ios_new, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        shape: const CircleBorder(),
      ),
      onPressed: () => context.pop(),
      icon: Icon(icon),
      color: context.colors.foregroundPrimary,
      iconSize: 20,
    );
  }
}
