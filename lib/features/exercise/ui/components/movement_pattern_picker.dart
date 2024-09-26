import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class MovementPatternModal extends StatelessWidget {
  const MovementPatternModal({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DraggableSheet(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: child,
      ),
    );
  }
}

class MovementPatternPicker extends StatelessWidget {
  const MovementPatternPicker({super.key});

  static const routePath = 'movement_pattern';
  static const routeName = 'movement_pattern_picker';

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      extendBody: true,
      backgroundColor: context.colors.backgroundPrimary,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView(
              children: [
                Section(
                  header: 'Movement Pattern',
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppLayout.p4,
                    vertical: AppLayout.p2,
                  ),
                  body: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: MovementPattern.values.length,
                    itemBuilder: (context, index) {
                      final equipment = MovementPattern.values[index];
                      return FlexListTile(
                        onTap: () => context.pop(equipment),
                        title: Text(
                          equipment.readableName,
                          style: context.typography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      indent: 54,
                      height: 0,
                      color: context.colors.divider,
                    ),
                  ),
                ),
                const SizedBox(height: AppLayout.bottomBuffer),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
