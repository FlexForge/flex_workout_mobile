import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/data/models/muscle_group_model.dart';
import 'package:flex_workout_mobile/features/exercise/ui/components/flex_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class MuscleGroupField extends StatelessWidget {
  const MuscleGroupField({
    required this.formControl,
    required this.label,
    required this.modalRouteName,
    super.key,
  });

  final String label;
  final FormControl<List<MuscleGroupModel>>? formControl;
  final String modalRouteName;

  @override
  Widget build(BuildContext context) {
    return FlexPicker(
      formControl: formControl,
      displayBuilder: (muscleGroups, field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: Text(
              label,
              style: context.typography.labelMedium,
            ),
          ),
          const SizedBox(height: AppLayout.p2),
          if (muscleGroups != null)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: muscleGroups.length,
              itemBuilder: (context, index) {
                final muscleGroup = muscleGroups[index];
                return Padding(
                  padding: const EdgeInsets.only(left: AppLayout.p2),
                  child: FlexListTile(title: Text(muscleGroup.name)),
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: context.colors.divider,
                indent: 62,
              ),
            ),
          const SizedBox(height: AppLayout.p1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
            child: FlexButton(
              onPressed: () async {
                final musclesGroups = await context.pushNamed(modalRouteName)
                    as List<MuscleGroupModel>?;

                field.didChange(musclesGroups);
              },
              expanded: true,
              label: 'Add Muscle Group',
              icon: Symbols.add,
              backgroundColor: context.colors.backgroundTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
