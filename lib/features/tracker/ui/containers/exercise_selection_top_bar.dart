import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';

class ExerciseSelectionTopBar extends StatelessWidget {
  const ExerciseSelectionTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: AppLayout.p4,
        right: AppLayout.p4,
        bottom: AppLayout.p2,
      ),
    );
  }
}
