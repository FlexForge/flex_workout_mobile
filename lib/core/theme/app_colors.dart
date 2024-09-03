import 'package:flutter/material.dart';

abstract class AppColors {
  static const darkModeColors = _DarkMode();
  static const lightModeColors = _LightMode();
}

class _DarkMode {
  const _DarkMode();

  Color get backgroundPrimary => const Color(0xFF1C1C1E);
  Color get backgroundSecondary => const Color(0xFF2C2C2E);
  Color get backgroundTertiary => const Color(0xFF3A3A3C);
  Color get backgroundQuaternary => const Color(0xFF48484A);

  Color get foregroundPrimary => const Color(0xFFFFFFFF);
  Color get foregroundSecondary => const Color(0x99EBEBF5);
  Color get foregroundTertiary => const Color(0x4DEBEBF5);
  Color get foregroundQuaternary => const Color(0x30EBEBF5);

  Color get divider => const Color(0xA6545458);

  Color get overlay => const Color(0x99000000);

  Color get pink => const Color(0xFFFE7FA2);
  Color get purple => const Color(0xFFB28DF7);
  Color get blue => const Color(0xFF679FFB);
  Color get green => const Color(0xFF5DBA87);
  Color get yellow => const Color(0xFFFFD15E);
  Color get orange => const Color(0xFFFF8660);
  Color get red => const Color(0xFFFF6A6A);
  Color get teal => const Color(0xFF6AD4D1);
  Color get cyan => const Color(0xFF6ACBD4);
  Color get lime => const Color(0xFFD4FF8C);
  Color get indigo => const Color(0xFF8CD4FF);
  Color get magenta => const Color(0xFFFF8CFF);
  Color get amber => const Color(0xFFFFD88C);
}

class _LightMode {
  const _LightMode();

  Color get backgroundPrimary => const Color(0xFFF2F2F7);
  Color get backgroundSecondary => const Color(0xFFFFFFFF);
  Color get backgroundTertiary => const Color(0xFFF2F2F7);
  Color get backgroundQuaternary => const Color(0xFFE5E5EA);

  Color get foregroundPrimary => const Color(0xFF000000);
  Color get foregroundSecondary => const Color(0x993C3C43);
  Color get foregroundTertiary => const Color(0x4D3C3C43);
  Color get foregroundQuaternary => const Color(0x303C3C43);

  Color get divider => const Color(0x313C3C43);

  Color get overlay => const Color(0x18000000);

  Color get pink => const Color(0xFFFEB2BF);
  Color get purple => const Color(0xFFD3BBFF);
  Color get blue => const Color(0xFFABC7FF);
  Color get green => const Color(0xFF9DD9B9);
  Color get yellow => const Color(0xFFFFDF97);
  Color get orange => const Color(0xFFFFB59F);
  Color get red => const Color(0xFFFF7C7C);
  Color get teal => const Color(0xFF7CE0D3);
  Color get cyan => const Color(0xFF7CD3E0);
  Color get lime => const Color(0xFFD3FFB8);
  Color get indigo => const Color(0xFFB8D3FF);
  Color get magenta => const Color(0xFFFFB8FF);
  Color get amber => const Color(0xFFFFD8B8);
}
