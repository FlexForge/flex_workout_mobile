import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/features/auth/controllers/user_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userInfoControllerProvider);

    return Section(
      header: 'General',
      body: Column(
        children: [
          FlexListTile(
            disabledForegroundColor: context.colors.foregroundPrimary,
            title: Text(
              'Name',
              style: context.typography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            icon: Icons.badge,
            suffix: Text(
              '${user.firstName} ${user.lastName}',
              style: context.typography.bodyMedium.copyWith(
                color: context.colors.foregroundSecondary,
              ),
            ),
          ),
          Divider(indent: 54, height: 1, color: context.colors.divider),
          FlexListTile(
            disabledForegroundColor: context.colors.foregroundPrimary,
            title: Text(
              'Email',
              style: context.typography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            icon: Icons.mail,
            suffix: Text(
              user.email,
              style: context.typography.bodyMedium.copyWith(
                color: context.colors.foregroundSecondary,
              ),
            ),
          ),
          Divider(indent: 54, height: 1, color: context.colors.divider),
          FlexListTile(
            disabledForegroundColor: context.colors.foregroundPrimary,
            title: Text(
              'Sex',
              style: context.typography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            icon: Icons.male,
            suffix: Text(
              user.isMale ? 'Male' : 'Female',
              style: context.typography.bodyMedium.copyWith(
                color: context.colors.foregroundSecondary,
              ),
            ),
          ),
          if (user.birthDate != null) ...[
            Divider(indent: 54, height: 1, color: context.colors.divider),
            FlexListTile(
              disabledForegroundColor: context.colors.foregroundPrimary,
              title: Text(
                'Birthday',
                style: context.typography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              icon: Icons.cake,
              suffix: Text(
                DateFormat.yMMMMd().format(user.birthDate!),
                style: context.typography.bodyMedium.copyWith(
                  color: context.colors.foregroundSecondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
