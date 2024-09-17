import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flex_workout_mobile/features/system/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../auth/_stores/user_store.dart';

void main() {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  ProviderContainer createThemeContainer() {
    return ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(mockUserRepository),
      ],
    );
  }

  group('ThemeController', () {
    group('build', () {
      test('should return user theme mode when user exists', () {
        const expected = ThemeMode.dark;

        when(
          () => mockUserRepository.getUser(),
        ).thenReturn(
          right(UserModelGenerator.single(preferredTheme: expected)),
        );

        final container = createThemeContainer();
        final res = container.read(themeControllerProvider);

        expect(res, expected);
      });

      test('should return system theme mode when user does not exist', () {
        const expected = ThemeMode.system;

        when(
          () => mockUserRepository.getUser(),
        ).thenReturn(
          left(const Failure.internalServerError(message: 'Error')),
        );

        final container = createThemeContainer();
        final res = container.read(themeControllerProvider);

        expect(res, expected);
      });
    });
    group('handle', () {
      test('should update user theme mode', () {
        const expected = ThemeMode.dark;

        when(
          () => mockUserRepository.updateTheme(theme: expected),
        ).thenReturn(
          right(expected),
        );

        final container = createThemeContainer();
        container.read(themeControllerProvider.notifier).handle(expected);

        final res = container.read(themeControllerProvider);

        expect(res, expected);
      });
    });
  });
}
