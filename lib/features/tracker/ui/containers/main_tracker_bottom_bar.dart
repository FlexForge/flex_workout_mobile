import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainTrackerBottomBar extends ConsumerWidget {
  const MainTrackerBottomBar({required this.next, super.key});

  final VoidCallback next;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.colors.divider), // Top border
        ),
      ),
      child: BottomAppBar(
        color: context.colors.backgroundPrimary,
        padding: EdgeInsets.zero,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: LargeButton(
                  onPressed: next,
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
    );
  }
}
