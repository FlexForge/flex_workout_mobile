import 'package:flex_workout_mobile/core/common/ui/components/flex_alert_dialog.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/tracker/ui/containers/normal_set_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class NormalSetScreenModal extends StatelessWidget {
  const NormalSetScreenModal({
    required this.nestedNavigator,
    super.key,
  });

  final Widget nestedNavigator;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldPop = await showFlexAlertDialog<bool>(
            context,
            title: 'Hold on!',
            description: 'By exiting without saving, your changes will be lost'
                " and your set won't be recorded."
                ' Are you sure you want to exit?',
            onPressed: () => context.pop(true),
          );

          if (shouldPop != null && shouldPop && context.mounted) {
            context.pop();
          }
        }
      },
      child: SheetKeyboardDismissible(
        dismissBehavior: const SheetKeyboardDismissBehavior.onDragDown(),
        child: DraggableSheet(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: nestedNavigator,
          ),
        ),
      ),
    );
  }
}

class NormalSetScreen extends StatelessWidget {
  const NormalSetScreen({super.key});

  static const routePath = 'normal_set';
  static const routeName = 'normal_set_form';

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      extendBody: true,
      backgroundColor: context.colors.backgroundPrimary,
      body: const Padding(
        padding:
            EdgeInsets.fromLTRB(AppLayout.p4, AppLayout.p4, AppLayout.p4, 0),
        child: NormalSetForm(),
      ),
    );
  }
}
