import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class EquipmentModal extends StatelessWidget {
  const EquipmentModal({required this.child, super.key});

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

class EquipmentPicker extends StatelessWidget {
  const EquipmentPicker({super.key});

  static const routePath = 'equipment';
  static const routeName = 'equipment_picker';

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      extendBody: true,
      backgroundColor: context.colors.backgroundSecondary,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppLayout.p2),
          Row(
            children: [
              const SizedBox(width: AppLayout.p4),
              Text(
                'Equipment',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: context.typography.headlineMedium
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              FlexButton(
                onPressed: context.pop,
                icon: Symbols.close,
                iconSize: 16,
                iconWeight: 700,
                padding: const EdgeInsets.all(AppLayout.p1),
                borderRadius: AppLayout.roundedRadius,
                iconColor: context.colors.foregroundSecondary,
                backgroundColor: context.colors.backgroundTertiary,
              ),
              const SizedBox(width: AppLayout.p4),
            ],
          ),
          const SizedBox(height: AppLayout.p2),
          ListView.separated(
            itemCount: Equipment.values.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final equipment = Equipment.values[index];
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
        ],
      ),
    );
  }
}
