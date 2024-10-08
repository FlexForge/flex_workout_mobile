import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserEntity {
  UserEntity(
    this.firstName,
    this.lastName,
    this.email, {
    this.id = 0,
    this.isMale = true,
    this.preferredTheme = ThemeMode.system,
    this.preferredWeightUnit = WeightUnit.kg,
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

  @Transient()
  WeightUnit preferredWeightUnit;

  int get dbPreferredWeightUnit {
    _ensureStableEnumValues();
    return preferredWeightUnit.index;
  }

  set dbPreferredWeightUnit(int value) {
    _ensureStableEnumValues();
    preferredWeightUnit = value >= 0 && value < WeightUnit.values.length
        ? WeightUnit.values[value]
        : WeightUnit.kg;
  }

  @Property(type: PropertyType.date)
  DateTime? updatedAt;
  @Property(type: PropertyType.date)
  DateTime? createdAt;

  void _ensureStableEnumValues() {
    assert(ThemeMode.system.index == 0, 'Enum values changed');
    assert(ThemeMode.light.index == 1, 'Enum values changed');
    assert(ThemeMode.dark.index == 2, 'Enum values changed');

    assert(WeightUnit.kg.index == 0, 'Enum values changed');
    assert(WeightUnit.lb.index == 1, 'Enum values changed');
  }
}

extension ConvertUser on UserEntity {
  UserModel toModel() => UserModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        birthDate: birthDate,
        isMale: isMale,
        userName: userName,
        preferredTheme: preferredTheme,
        preferredWeightUnit: preferredWeightUnit,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
}
