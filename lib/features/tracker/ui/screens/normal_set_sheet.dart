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
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await showFlexAlertDialog(
            context,
            title: 'Hold on!',
            description: 'By exiting without saving, your changes will be lost'
                " and your set won't be recorded."
                ' Are you sure you want to exit?',
            onPressed: () => context
              ..pop()
              ..pop(),
          );
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
  const NormalSetScreen({
    required this.sectionIndex,
    required this.organizerIndex,
    this.setIndex,
    super.key,
  });

  static const routePath = 'normal_set/:sectionIndex/:organizerIndex/:setIndex';
  static const routeName = 'normal_set_form';

  final int sectionIndex;
  final int organizerIndex;
  final int? setIndex;

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      extendBody: true,
      backgroundColor: context.colors.backgroundPrimary,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppLayout.p4,
          AppLayout.p4,
          AppLayout.p4,
          0,
        ),
        child: NormalSetInputForm(
          sectionIndex: sectionIndex,
          organizerIndex: organizerIndex,
          setIndex: setIndex,
        ),
      ),
    );
  }
}
