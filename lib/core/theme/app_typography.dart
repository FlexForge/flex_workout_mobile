import 'package:flutter/material.dart';

abstract class AppTypography {
  static const title = _Title();
  static const headline = _Headline();
  static const label = _Label();
  static const body = _Body();
}

class _Title {
  const _Title();
  TextStyle get large => const TextStyle(
        fontSize: 32,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 40 / 32,
        letterSpacing: 0,
      );

  TextStyle get medium => const TextStyle(
        fontSize: 28,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 36 / 28,
        letterSpacing: 0,
      );

  TextStyle get small => const TextStyle(
        fontSize: 24,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 32 / 24,
        letterSpacing: 0,
      );
}

class _Headline {
  const _Headline();
  TextStyle get large => const TextStyle(
        fontSize: 22,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 28 / 22,
        letterSpacing: 0,
      );

  TextStyle get medium => const TextStyle(
        fontSize: 16,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 24 / 16,
        letterSpacing: 0.15,
      );

  TextStyle get small => const TextStyle(
        fontSize: 14,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        letterSpacing: 0.1,
      );
}

class _Label {
  const _Label();
  TextStyle get large => const TextStyle(
        fontSize: 14,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        letterSpacing: 0.1,
      );

  TextStyle get medium => const TextStyle(
        fontSize: 12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        letterSpacing: 0.5,
      );

  TextStyle get small => const TextStyle(
        fontSize: 11,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 16 / 11,
        letterSpacing: 0.5,
      );

  TextStyle get xSmall => const TextStyle(
        fontSize: 10,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 10 / 10,
        letterSpacing: -0.24,
      );
}

class _Body {
  const _Body();
  TextStyle get large => const TextStyle(
        fontSize: 16,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        letterSpacing: 0.5,
      );

  TextStyle get medium => const TextStyle(
        fontSize: 14,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        letterSpacing: 0.25,
      );

  TextStyle get small => const TextStyle(
        fontSize: 12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        letterSpacing: 0,
      );
}
