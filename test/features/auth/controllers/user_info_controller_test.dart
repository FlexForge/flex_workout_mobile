import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/auth/controllers/user_info_controller.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  ProviderContainer createUserInfoContainer() {
    return createContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(mockUserRepository),
      ],
    );
  }

  group('UserInfoController', () {
    test('should return user on call', () {
      final expected = UserModel(
        id: faker.randomGenerator.integer(9999),
        firstName: faker.person.firstName(),
        lastName: faker.person.lastName(),
        email: faker.internet.email(),
        isMale: faker.randomGenerator.boolean(),
        preferredTheme: ThemeMode.system,
      );

      when(
        () => mockUserRepository.getUser(),
      ).thenReturn(right(expected));

      final container = createUserInfoContainer();
      final res = container.read(userInfoControllerProvider);

      expect(res, expected);
    });
  });

  test('should throw error on repository error', () {
    when(
      () => mockUserRepository.getUser(),
    ).thenReturn(left(const Failure.internalServerError(message: 'Error')));

    final container = createUserInfoContainer();

    try {
      container.read(userInfoControllerProvider);
    } catch (e) {
      expect(e.toString(), 'Failure.internalServerError(message: Error)');
    }
  });
}
