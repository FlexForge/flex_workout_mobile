import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/cupertino.dart';

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: context.colors.backgroundPrimary,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppLayout.cornerRadius),
        ),
      ),
      child: Center(
        child: Container(
          height: 5,
          width: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32 / 2),
            color: context.colors.backgroundSecondary,
          ),
        ),
      ),
    );
  }
}
