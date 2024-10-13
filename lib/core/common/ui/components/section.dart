import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({
    required this.body,
    this.header,
    this.subHeader,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    this.onTap,
    super.key,
  });

  final String? header;
  final String? subHeader;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final Widget body;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null)
            Text(
              header!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: context.typography.headlineMedium
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          if (header != null) const SizedBox(height: AppLayout.p3),
          GestureDetector(
            onTap: onTap,
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor ?? context.colors.backgroundSecondary,
                borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subHeader != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppLayout.p4,
                        top: AppLayout.p4,
                        right: AppLayout.p2,
                      ),
                      child: Text(
                        subHeader!,
                        style: context.typography.headlineSmall
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  body,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
