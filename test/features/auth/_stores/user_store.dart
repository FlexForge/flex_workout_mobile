import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/auth/data/db/user_entity.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UserModelGenerator {
  static UserModel single(
      {ThemeMode? preferredTheme,
      Units? preferredWeightUnit,
      DateTime? createdAt}) {
    return UserModel(
      id: faker.randomGenerator.integer(9999),
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      email: faker.internet.email(),
      isMale: faker.randomGenerator.boolean(),
      preferredTheme: preferredTheme ??
          faker.randomGenerator
              .element([ThemeMode.dark, ThemeMode.light, ThemeMode.system]),
      preferredWeightUnit: preferredWeightUnit ??
          faker.randomGenerator.element([Units.kgs, Units.lbs]),
      userName: faker.internet.userName(),
      birthDate: faker.date.dateTime(),
      updatedAt: faker.date.dateTime(),
      createdAt: createdAt ?? faker.date.dateTime(),
    );
  }
}

class UserEntityGenerator {
  static UserEntity single() {
    return UserEntity(
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
