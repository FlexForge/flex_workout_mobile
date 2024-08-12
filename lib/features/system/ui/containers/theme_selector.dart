import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/system/controllers/theme_controller.dart';
import 'package:flex_workout_mobile/features/system/ui/components/theme_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider);

    return Section(
      header: 'Theme',
      backgroundColor: context.colors.backgroundPrimary,
      body: Row(
        children: [
          ThemeDisplay(
            theme: ThemeMode.system,
            label: 'System',
            onPressed: () => ref
                .read(themeControllerProvider.notifier)
                .handle(ThemeMode.system),
            isSelected: theme == ThemeMode.system,
          ),
          const SizedBox(width: AppLayout.p4),
          ThemeDisplay(
            theme: ThemeMode.light,
            label: 'Light',
            onPressed: () => ref
                .read(themeControllerProvider.notifier)
                .handle(ThemeMode.light),
            isSelected: theme == ThemeMode.light,
          ),
          const SizedBox(width: AppLayout.p4),
          ThemeDisplay(
            theme: ThemeMode.dark,
            label: 'Dark',
            onPressed: () => ref
                .read(themeControllerProvider.notifier)
                .handle(ThemeMode.dark),
            isSelected: theme == ThemeMode.dark,
          ),
        ],
      ),
    );
  }
}
