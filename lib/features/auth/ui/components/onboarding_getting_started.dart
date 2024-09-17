import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingStepOne extends ConsumerWidget {
  const OnboardingStepOne({required this.next, super.key});

  final VoidCallback next;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget bulletPoint(String text) => Row(
          children: [
            const Icon(
              Icons.circle,
              size: 16,
            ),
            const SizedBox(width: AppLayout.p2),
            Text(
              text,
              style: context.typography.bodyLarge.copyWith(),
            ),
          ],
        );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: context.colors.foregroundPrimary,
                    child: Icon(
                      Icons.apps,
                      color: context.colors.backgroundPrimary,
                    ),
                  ),
                  const SizedBox(width: AppLayout.p2),
                  Text(
                    'flex starter',
                    style: context.typography.headlineMedium
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: AppLayout.p6 * 2),
              Text(
                'What you get',
                style: context.typography.headlineLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppLayout.p6),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'A ',
                      style: context.typography.bodyLarge.copyWith(
                        color: context.colors.foregroundPrimary,
                      ),
                    ),
                    TextSpan(
                      text: 'complete and functional ',
                      style: context.typography.bodyLarge.copyWith(
                        color: context.colors.foregroundPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'starting point for ',
                      style: context.typography.bodyLarge.copyWith(
                        color: context.colors.foregroundPrimary,
                      ),
                    ),
                    TextSpan(
                      text: 'your next flutter app ',
                      style: context.typography.bodyLarge.copyWith(
                        color: context.colors.foregroundPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'that includes:',
                      style: context.typography.bodyLarge.copyWith(
                        color: context.colors.foregroundPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppLayout.p6),
              bulletPoint('built using clean architecture'),
              const SizedBox(height: AppLayout.p2),
              bulletPoint('local first database with objectbox'),
              const SizedBox(height: AppLayout.p2),
              bulletPoint('support for multiple build environments'),
              const SizedBox(height: AppLayout.p2),
              bulletPoint('a complete navigation solution'),
              const SizedBox(height: AppLayout.p2),
              bulletPoint('100% test coverage with flutter-test'),
              const SizedBox(height: AppLayout.p2),
              bulletPoint('workflows for building, and releasing'),
              const SizedBox(height: AppLayout.p2),
              bulletPoint('form handling with validations'),
              const SizedBox(height: AppLayout.p2),
              bulletPoint('multiple language localization'),
              const SizedBox(height: AppLayout.p2),
              bulletPoint('dark and light themes'),
              const SizedBox(height: AppLayout.p6 * 2),
            ],
          ),
        ),
        Positioned(
          bottom: AppLayout.p4,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Divider(
                height: 1,
                color: context.colors.divider,
              ),
              const SizedBox(height: AppLayout.p4),
              Text(
                'Minimal • Complete • Ready',
                style: context.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppLayout.p4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppLayout.p4),
                child: FlexButton(
                  label: 'Get started now',
                  expanded: true,
                  onPressed: next,
                  backgroundColor: context.colors.foregroundPrimary,
                  foregroundColor: context.colors.backgroundPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
