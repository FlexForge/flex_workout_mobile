import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_colors.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/material.dart';

class ThemeDisplay extends StatelessWidget {
  const ThemeDisplay({
    required this.theme,
    required this.label,
    required this.onPressed,
    required this.isSelected,
    super.key,
  });

  final String label;
  final ThemeMode theme;

  final void Function()? onPressed;
  final bool isSelected;

  Color getThemeColor(Color systemColor, Color lightColor, Color darkColor) {
    switch (theme) {
      case ThemeMode.system:
        return systemColor;
      case ThemeMode.light:
        return lightColor;
      case ThemeMode.dark:
        return darkColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 88,
            clipBehavior: Clip.hardEdge,
            foregroundDecoration: BoxDecoration(
              border: Border.all(
                color: getThemeColor(
                  isSelected
                      ? context.colors.foregroundPrimary
                      : context.colors.foregroundQuaternary,
                  isSelected
                      ? AppColors.lightModeColors.foregroundPrimary
                      : AppColors.lightModeColors.backgroundSecondary,
                  isSelected
                      ? AppColors.darkModeColors.foregroundPrimary
                      : AppColors.darkModeColors.backgroundTertiary,
                ),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
            ),
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: context.colors.foregroundSecondary,
                backgroundColor: context.colors.backgroundTertiary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppLayout.cornerRadius),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: getThemeColor(
                              AppColors.lightModeColors.backgroundPrimary,
                              AppColors.lightModeColors.backgroundPrimary,
                              AppColors.darkModeColors.backgroundPrimary,
                            ),
                            padding: const EdgeInsets.only(left: AppLayout.p2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Aa',
                                  style: context.typography.labelLarge.copyWith(
                                    color: getThemeColor(
                                      AppColors
                                          .lightModeColors.foregroundPrimary,
                                      AppColors
                                          .lightModeColors.foregroundPrimary,
                                      AppColors
                                          .darkModeColors.foregroundPrimary,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 3,
                                      backgroundColor: getThemeColor(
                                        AppColors.lightModeColors.orange,
                                        AppColors.lightModeColors.orange,
                                        AppColors.darkModeColors.orange,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    CircleAvatar(
                                      radius: 3,
                                      backgroundColor: getThemeColor(
                                        AppColors.lightModeColors.yellow,
                                        AppColors.lightModeColors.yellow,
                                        AppColors.darkModeColors.yellow,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    CircleAvatar(
                                      radius: 3,
                                      backgroundColor: getThemeColor(
                                        AppColors.lightModeColors.green,
                                        AppColors.lightModeColors.green,
                                        AppColors.darkModeColors.green,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    CircleAvatar(
                                      radius: 3,
                                      backgroundColor: getThemeColor(
                                        AppColors.lightModeColors.purple,
                                        AppColors.lightModeColors.purple,
                                        AppColors.darkModeColors.purple,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppLayout.p1),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: theme == ThemeMode.system
                              ? Container(
                                  color: AppColors
                                      .darkModeColors.backgroundPrimary,
                                  padding:
                                      const EdgeInsets.only(left: AppLayout.p2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: AppLayout.p1),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 3,
                                            backgroundColor:
                                                AppColors.darkModeColors.orange,
                                          ),
                                          const SizedBox(width: 2),
                                          CircleAvatar(
                                            radius: 3,
                                            backgroundColor:
                                                AppColors.darkModeColors.yellow,
                                          ),
                                          const SizedBox(width: 2),
                                          CircleAvatar(
                                            radius: 3,
                                            backgroundColor:
                                                AppColors.darkModeColors.green,
                                          ),
                                          const SizedBox(width: 2),
                                          CircleAvatar(
                                            radius: 3,
                                            backgroundColor:
                                                AppColors.darkModeColors.purple,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Aa',
                                        style: context.typography.labelLarge
                                            .copyWith(
                                          color: AppColors
                                              .darkModeColors.foregroundPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  color: getThemeColor(
                                    AppColors.darkModeColors.backgroundPrimary,
                                    AppColors.lightModeColors.backgroundPrimary,
                                    AppColors.darkModeColors.backgroundPrimary,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: getThemeColor(
                              AppColors.lightModeColors.backgroundSecondary,
                              AppColors.lightModeColors.backgroundSecondary,
                              AppColors.darkModeColors.backgroundSecondary,
                            ),
                            padding: const EdgeInsets.fromLTRB(6, 8, 8, 2),
                            child: Column(
                              children: [
                                Expanded(child: demoContainer()),
                                const SizedBox(height: AppLayout.p1),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(child: demoContainer()),
                                      const SizedBox(width: AppLayout.p1),
                                      Expanded(child: demoContainer()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: getThemeColor(
                              AppColors.darkModeColors.backgroundSecondary,
                              AppColors.lightModeColors.backgroundSecondary,
                              AppColors.darkModeColors.backgroundSecondary,
                            ),
                            padding: const EdgeInsets.fromLTRB(6, 2, 8, 8),
                            child: Column(
                              children: [
                                Expanded(
                                  child: demoContainer(systemDark: true),
                                ),
                                const SizedBox(height: AppLayout.p1),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: demoContainer(systemDark: true),
                                      ),
                                      const SizedBox(width: AppLayout.p1),
                                      Expanded(
                                        child: demoContainer(systemDark: true),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppLayout.p2),
          Text(
            label,
            style: context.typography.labelMedium.copyWith(
              color: isSelected
                  ? context.colors.foregroundPrimary
                  : context.colors.foregroundSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Container demoContainer({
    bool systemDark = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: getThemeColor(
          systemDark
              ? AppColors.darkModeColors.backgroundTertiary
              : AppColors.lightModeColors.backgroundTertiary,
          AppColors.lightModeColors.backgroundTertiary,
          AppColors.darkModeColors.backgroundTertiary,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
