import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/auth/controllers/user_create_controller.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_form_model.dart';
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

  ProviderContainer createUserCreateContainer() {
    return createContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(mockUserRepository),
      ],
    );
  }

  group('UserCreateController', () {
    test('should return null on call', () {
      final container = createUserCreateContainer();
      final res = container.read(userCreateControllerProvider);

      expect(res, null);
    });

    group('handle', () {
      final firstName = faker.person.firstName();
      final lastName = faker.person.lastName();
      final mockUser = User(
        name: '$firstName $lastName',
        email: faker.internet.email(),
        sex: faker.randomGenerator.boolean() ? 1 : 0,
      );

      test('should create post when all form items are filled', () {
        final inputForm = UserForm(UserForm.formElements(mockUser), null);

        final expected = UserModel(
          id: faker.randomGenerator.integer(9999),
          firstName: firstName,
          lastName: lastName,
          email: mockUser.email!,
          isMale: mockUser.sex! == 1,
          preferredTheme: ThemeMode.system,
        );

        when(
          () => mockUserRepository.createUser(
            firstName: firstName,
            lastName: lastName,
            email: mockUser.email!,
            isMale: mockUser.sex! == 1,
          ),
        ).thenReturn(right(expected));

        final container = createUserCreateContainer();
        container.read(userCreateControllerProvider.notifier).handle(inputForm);

        final res = container.read(userCreateControllerProvider);

        expect(res, expected);
      });

      test('should return null when name is null', () {
        final inputUser = mockUser.copyWith(name: null);
        final inputForm = UserForm(UserForm.formElements(inputUser), null);

        final container = createUserCreateContainer();
        container.read(userCreateControllerProvider.notifier).handle(inputForm);

        final res = container.read(userCreateControllerProvider);

        expect(res, null);
      });

      test('should return null when email is null', () {
        final inputUser = mockUser.copyWith(email: null);
        final inputForm = UserForm(UserForm.formElements(inputUser), null);

        final container = createUserCreateContainer();
        container.read(userCreateControllerProvider.notifier).handle(inputForm);

        final res = container.read(userCreateControllerProvider);

        expect(res, null);
      });

      test('should return null when sex is null', () {
        final inputUser = mockUser.copyWith(sex: null);
        final inputForm = UserForm(UserForm.formElements(inputUser), null);

        final container = createUserCreateContainer();
        container.read(userCreateControllerProvider.notifier).handle(inputForm);

        final res = container.read(userCreateControllerProvider);

        expect(res, null);
      });
    });
  });
}
