import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showFlexAlertDialog(
  BuildContext context, {
  String? title,
  String? description,
  Widget? child,
  void Function()? onPressed,
  String? actionLabel,
  String? cancelLabel,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: context.colors.backgroundSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
        ),
        titlePadding: const EdgeInsets.fromLTRB(
          AppLayout.p4,
          AppLayout.p4,
          AppLayout.p4,
          AppLayout.p1,
        ),
        contentPadding: const EdgeInsets.fromLTRB(
          AppLayout.p4,
          AppLayout.p1,
          AppLayout.p4,
          AppLayout.p4,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          AppLayout.p4,
          0,
          AppLayout.p4,
          AppLayout.p4,
        ),
        insetPadding: const EdgeInsets.all(AppLayout.p4),
        title: title != null ? Text(title) : null,
        titleTextStyle: context.typography.headlineLarge.copyWith(
          color: context.colors.foregroundPrimary,
          fontWeight: FontWeight.w600,
        ),
        content: description != null
            ? Text(description)
            : SizedBox(
                width: double.infinity,
                child: child,
              ),
        contentTextStyle: context.typography.bodyMedium.copyWith(
          color: context.colors.foregroundPrimary,
        ),
        actions: <Widget>[
          LargeButton(
            label: cancelLabel ?? 'Cancel',
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(
              horizontal: AppLayout.p6,
              vertical: AppLayout.p3,
            ),
            onPressed: () => context.pop(),
          ),
          LargeButton(
            label: actionLabel ?? 'Confirm',
            backgroundColor: context.colors.foregroundPrimary,
            foregroundColor: context.colors.backgroundPrimary,
            borderRadius: AppLayout.cornerRadius,
            padding: const EdgeInsets.symmetric(
              horizontal: AppLayout.p6,
              vertical: AppLayout.p3,
            ),
            onPressed: onPressed,
          ),
        ],
      );
    },
  );
}
