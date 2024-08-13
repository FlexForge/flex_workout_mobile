import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/auth/data/db/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserEntity', () {
    group('enums', () {
      const theme = ThemeMode.light;

      final entity = User(
        faker.person.firstName(),
        faker.person.lastName(),
        faker.internet.email(),
        preferredTheme: theme,
      );

      test('get dbPreferredTheme', () {
        expect(entity.dbPreferredTheme, 2);
      });

      test('set dbPreferredTheme', () {
        entity.dbPreferredTheme = ThemeMode.dark.index;
        expect(entity.preferredTheme, ThemeMode.dark);
      });
    });

    group('extensions', () {
      test('ConvertUser', () {
        final entity = User(
          faker.person.firstName(),
          faker.person.lastName(),
          faker.internet.email(),
        );
        final res = entity.toModel();

        expect(res.firstName, entity.firstName);
        expect(res.lastName, entity.lastName);
        expect(res.email, entity.email);
      });
    });
  });
}
