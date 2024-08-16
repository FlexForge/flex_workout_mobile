import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class TrackerBottomBar extends StatelessWidget {
  const TrackerBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.backgroundSecondary,
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: BottomAppBar(
            color: context.colors.backgroundSecondary,
            padding: EdgeInsets.zero,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: LargeButton(
                      onPressed: () => context.pop(),
                      label: 'Finish',
                      icon: Symbols.check,
                      backgroundColor: context.colors.foregroundPrimary,
                      foregroundColor: context.colors.backgroundPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
