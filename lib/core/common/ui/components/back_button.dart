import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FlexBackButton extends StatelessWidget {
  const FlexBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        shape: const CircleBorder(),
      ),
      onPressed: () => context.pop(),
      icon: const Icon(
        Icons.arrow_back_ios_new,
      ),
      color: context.colors.foregroundPrimary,
      iconSize: 20,
    );
  }
}
