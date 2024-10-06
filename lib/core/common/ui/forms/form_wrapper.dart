import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';

class FormWrapper extends StatelessWidget {
  const FormWrapper({
    required this.form,
    this.actionButtons,
    this.backgroundColor,
    this.padding,
    super.key,
  });

  final Widget form;
  final List<Widget>? actionButtons;

  final Color? backgroundColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.colors.backgroundSecondary,
      body: SizedBox.expand(
        child: Stack(
          children: [
            ListView(
              padding: padding ??
                  const EdgeInsets.only(
                    top: AppLayout.p6,
                    bottom: AppLayout.bottomBuffer,
                  ),
              clipBehavior: Clip.none,
              children: [
                form,
                const SizedBox(
                  height: AppLayout.bottomBuffer,
                ),
              ],
            ),
            if (actionButtons != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppLayout.p4,
                    vertical: AppLayout.p2,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 0.5],
                      colors: [
                        backgroundColor?.withOpacity(0) ??
                            context.colors.backgroundSecondary.withOpacity(0),
                        backgroundColor ?? context.colors.backgroundSecondary,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actionButtons!,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
