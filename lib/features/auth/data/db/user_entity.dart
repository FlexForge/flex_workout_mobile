import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  User(
    this.firstName,
    this.lastName,
    this.email, {
    this.id = 0,
    this.isMale = true,
    this.preferredTheme = ThemeMode.system,
    this.userName,
    this.birthDate,
    this.updatedAt,
    this.createdAt,
  });

  @Id()
  int id = 0;

  String firstName;
  String lastName;
  String email;
  bool isMale;

  String? userName;
  @Property(type: PropertyType.date)
  DateTime? birthDate;

  @Transient()
  ThemeMode preferredTheme;

  int get dbPreferredTheme {
    _ensureStableEnumValues();
    return preferredTheme.index;
  }

  set dbPreferredTheme(int value) {
    _ensureStableEnumValues();
    preferredTheme = value >= 0 && value < ThemeMode.values.length
        ? ThemeMode.values[value]
        : ThemeMode.system;
  }

  @Property(type: PropertyType.date)
  DateTime? updatedAt;
  @Property(type: PropertyType.date)
  DateTime? createdAt;

  void _ensureStableEnumValues() {
    assert(ThemeMode.system.index == 0, 'Enum values changed');
    assert(ThemeMode.light.index == 1, 'Enum values changed');
    assert(ThemeMode.dark.index == 2, 'Enum values changed');
  }
}

extension ConvertUser on User {
  UserModel toModel() => UserModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        birthDate: birthDate,
        isMale: isMale,
        userName: userName,
        preferredTheme: preferredTheme,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
}
