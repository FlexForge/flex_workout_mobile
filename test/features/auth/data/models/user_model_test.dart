import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('UserModel', () {
    group('extensions', () {
      test('ConvertUser', () {
        final model = UserModel(
          id: faker.randomGenerator.integer(9999),
          firstName: faker.person.firstName(),
          lastName: faker.person.lastName(),
          email: faker.internet.email(),
          isMale: faker.randomGenerator.boolean(),
          preferredTheme: ThemeMode.system,
          birthDate: faker.date.dateTime(),
          userName: faker.person.name(),
          updatedAt: faker.date.dateTime(),
          createdAt: faker.date.dateTime(),
        );

        final res = model.toEntity();

        expect(res.firstName, model.firstName);
        expect(res.lastName, model.lastName);
        expect(res.email, model.email);
        expect(res.id, model.id);
        expect(res.isMale, model.isMale);
        expect(res.userName, model.userName);
        expect(res.birthDate, model.birthDate);
        expect(res.preferredTheme, model.preferredTheme);
        expect(res.updatedAt, model.updatedAt);
        expect(res.createdAt, model.createdAt);
      });

      group('formatCreatedDate', () {
        final model = UserModel(
          id: faker.randomGenerator.integer(9999),
          firstName: faker.person.firstName(),
          lastName: faker.person.lastName(),
          email: faker.internet.email(),
          isMale: faker.randomGenerator.boolean(),
          preferredTheme: ThemeMode.system,
          updatedAt: faker.date.dateTime(),
        );

        test('date is null', () {
          final noDateModel = model;
          final formattedDate = noDateModel.formatCreatedDate();

          expect(formattedDate, '');
        });

        test('date is not null', () {
          final date = faker.date.dateTime();
          final recentDateModel = model.copyWith(createdAt: date);
          final formattedDate = recentDateModel.formatCreatedDate();

          expect(formattedDate, DateFormat.yMMMMd().format(date));
        });
      });
    });
  });
}
