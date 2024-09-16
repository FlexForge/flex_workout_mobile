import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/auth/data/db/user_entity.dart';
import 'package:flutter/material.dart';

class UserEntityGenerator {
  static User single() {
    return User(
      faker.person.firstName(),
      faker.person.lastName(),
      faker.internet.email(),
      id: faker.randomGenerator.integer(9999),
      isMale: faker.randomGenerator.boolean(),
      preferredTheme: faker.randomGenerator
          .element([ThemeMode.dark, ThemeMode.light, ThemeMode.system]),
      userName: faker.internet.userName(),
      birthDate: faker.date.dateTime(),
      updatedAt: faker.date.dateTime(),
      createdAt: faker.date.dateTime(),
    );
  }
}
