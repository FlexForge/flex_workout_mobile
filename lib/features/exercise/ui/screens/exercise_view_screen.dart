import 'package:flex_workout_mobile/core/common/ui/components/back_button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_view_controller.dart';
import 'package:flex_workout_mobile/features/exercise/ui/containers/exercise_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseViewScreen extends ConsumerWidget {
  const ExerciseViewScreen({required this.id, super.key});

  final String id;

  static const routeName = 'exercise_view';
  static const routePath = 'exercise/:eid';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercise = ref.watch(exerciseViewControllerProvider(id));

    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      appBar: CupertinoNavigationBar(
        middle: Text(
          exercise.name,
          style: TextStyle(color: context.colors.foregroundPrimary),
        ),
        leading: const FlexBackButton(),
        backgroundColor: context.colors.backgroundSecondary,
        border: null,
        padding: EdgeInsetsDirectional.zero,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        child: Column(
          children: [
            ExerciseSummary(exercise: exercise),
          ],
        ),
      ),
    );
  }
}
