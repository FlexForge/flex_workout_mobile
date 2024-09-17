import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/search_bar.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ExerciseSelectionTopBar extends StatelessWidget {
  const ExerciseSelectionTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppLayout.p4,
        right: AppLayout.p4,
        bottom: AppLayout.p4,
        top: AppLayout.p4,
      ),
      child: Row(
        children: [
          Expanded(
            child: FlexSearchBar(
              onChanged: (value) {},
              hintText: 'Search...',
              prefixIcon: Symbols.search,
            ),
          ),
          const SizedBox(width: AppLayout.p2),
          FlexButton(
            onPressed: () {},
            icon: Icons.add,
            backgroundColor: context.colors.backgroundSecondary,
            foregroundColor: context.colors.foregroundPrimary,
          ),
        ],
      ),
    );
  }
}
