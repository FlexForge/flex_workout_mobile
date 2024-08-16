import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingIntro extends ConsumerWidget {
  const OnboardingIntro({required this.next, super.key});

  final VoidCallback next;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppLayout.p6 * 2),
          CircleAvatar(
            radius: 24,
            backgroundColor: context.colors.foregroundPrimary,
            child: Icon(
              Icons.apps,
              size: 24,
              color: context.colors.backgroundPrimary,
            ),
          ),
          const SizedBox(height: AppLayout.p6 * 2),
          Text(
            'minimal code',
            style: context.typography.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'easy setup',
            style: context.typography.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'better experience',
            style: context.typography.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppLayout.p6),
          Text(
            'with a starter Flex that\nis ready for everything',
            style: context.typography.headlineMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          LargeButton(
            onPressed: next,
            backgroundColor: context.colors.foregroundPrimary,
            foregroundColor: context.colors.backgroundPrimary,
            child: Stack(
              children: [
                const Positioned(
                  left: 0,
                  child: Icon(Icons.admin_panel_settings),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue Anonymously',
                      style: context.typography.labelLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppLayout.p6),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'By continuing you agree to no ',
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundPrimary,
                  ),
                ),
                TextSpan(
                  text: 'terms of service ',
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: 'or ',
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundPrimary,
                  ),
                ),
                TextSpan(
                  text: 'privacy policy ',
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: 'since there are none.',
                  style: context.typography.labelMedium.copyWith(
                    color: context.colors.foregroundPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppLayout.p6),
        ],
      ),
    );
  }
}
