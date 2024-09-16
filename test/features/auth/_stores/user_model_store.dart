import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UserModelGenerator {
  static UserModel single({DateTime? createdAt}) {
    return UserModel(
      id: faker.randomGenerator.integer(9999),
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      email: faker.internet.email(),
      isMale: faker.randomGenerator.boolean(),
      preferredTheme: faker.randomGenerator
          .element([ThemeMode.dark, ThemeMode.light, ThemeMode.system]),
      userName: faker.internet.userName(),
      birthDate: faker.date.dateTime(),
      updatedAt: faker.date.dateTime(),
      createdAt: createdAt ?? faker.date.dateTime(),
    );
  }
}
