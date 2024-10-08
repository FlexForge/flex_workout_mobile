import 'package:flex_workout_mobile/core/common/ui/components/back_button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_edit_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseEditScreen extends ConsumerWidget {
  const ExerciseEditScreen({required this.id, super.key});

  final String id;

  static const routeName = 'exercise_edit';
  static const routPath = 'exercise/:eid/edit';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercise = ref.watch(exerciseEditControllerProvider(id));

    return Scaffold(
      backgroundColor: context.colors.backgroundSecondary,
      appBar: CupertinoNavigationBar(
        middle: Text(
          'Edit ${exercise.name}',
          style: TextStyle(color: context.colors.foregroundPrimary),
        ),
        leading: const FlexBackButton(
          icon: Symbols.close,
        ),
        backgroundColor: context.colors.backgroundSecondary,
        border: null,
        padding: EdgeInsetsDirectional.zero,
      ),
      body: const Placeholder(),
    );
  }
}
