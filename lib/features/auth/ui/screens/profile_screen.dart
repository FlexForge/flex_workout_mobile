import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/auth/ui/containers/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = 'profile';

  static const routePath = 'profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      appBar: CupertinoNavigationBar(
        middle: Text(
          'Profile',
          style: TextStyle(color: context.colors.foregroundPrimary),
        ),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.chevron_left,
          ),
          color: context.colors.foregroundPrimary,
          iconSize: 24,
        ),
        backgroundColor: context.colors.backgroundSecondary,
        border: null,
        padding: EdgeInsetsDirectional.zero,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppLayout.p4),
        child: Column(
          children: [
            SizedBox(height: AppLayout.p6),
            Profile(),
          ],
        ),
      ),
    );
  }
}
