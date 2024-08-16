import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Main Bottom Navigation Bar
class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.showToolbarModalBottomSheet,
    super.key,
  });

  final int selectedIndex;
  final void Function(int) onItemTapped;

  final VoidCallback showToolbarModalBottomSheet;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.backgroundSecondary,
      child: SafeArea(
        child: BottomAppBar(
          color: context.colors.backgroundSecondary,
          padding: EdgeInsets.zero,
          height: 64,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: context.colors.divider), // Top border
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                navigationBarItems(
                  context,
                  index: 0,
                  label: 'Dashboard',
                  icon: Symbols.dashboard,
                ),
                navigationBarItems(
                  context,
                  index: 1,
                  label: 'History',
                  icon: Symbols.history,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: showToolbar(context),
                ),
                navigationBarItems(
                  context,
                  index: 2,
                  label: 'Library',
                  icon: Symbols.bookmark,
                ),
                navigationBarItems(
                  context,
                  index: 3,
                  label: 'More',
                  icon: CupertinoIcons.ellipsis_circle,
                  fillIcon: CupertinoIcons.ellipsis_circle_fill,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showToolbar(BuildContext context) {
    return IconButton.filled(
      icon: const Icon(Symbols.add),
      iconSize: 24,
      onPressed: showToolbarModalBottomSheet,
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(12),
        splashFactory: NoSplash.splashFactory,
        backgroundColor: context.colors.foregroundPrimary,
        foregroundColor: context.colors.backgroundPrimary,
      ),
    );
  }

  Widget navigationBarItems(
    BuildContext context, {
    required int index,
    required String label,
    required IconData icon,
    IconData? fillIcon,
  }) {
    bool isSelected(int index) {
      return selectedIndex == index;
    }

    return Expanded(
      child: TextButton(
        onPressed: () => onItemTapped(index),
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.padded,
          padding: const EdgeInsets.all(8),
          shape: const CircleBorder(),
        ).copyWith(
          // Define the splash color
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return context.colors.backgroundTertiary;
              }
              return null;
            },
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              size: 29,
              isSelected(index) && fillIcon != null ? fillIcon : icon,
              color: isSelected(index)
                  ? context.colors.foregroundPrimary
                  : context.colors.foregroundSecondary,
              fill: isSelected(index) ? 1 : 0,
              weight: 500,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 1,
              style: context.typography.labelSmall.copyWith(
                color: isSelected(index)
                    ? context.colors.foregroundPrimary
                    : context.colors.foregroundSecondary,
              ),
            ), // Reduced text size
          ],
        ),
      ),
    );
  }
}
