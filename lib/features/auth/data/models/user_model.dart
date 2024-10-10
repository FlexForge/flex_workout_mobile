import 'package:flex_workout_mobile/core/utils/enums.dart';
import 'package:flex_workout_mobile/features/auth/data/db/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required bool isMale,
    required ThemeMode preferredTheme,
    required Units preferredWeightUnit,
    DateTime? birthDate,
    String? userName,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) = _UserModel;
}

extension ConvertUserModel on UserModel {
  UserEntity toEntity() => UserEntity(
        firstName,
        lastName,
        email,
        id: id,
        isMale: isMale,
        userName: userName,
        birthDate: birthDate,
        preferredTheme: preferredTheme,
        preferredWeightUnit: preferredWeightUnit,
        updatedAt: updatedAt,
        createdAt: createdAt,
      );
}

extension FormatCreatedDate on UserModel {
  String formatCreatedDate() {
    if (createdAt == null) return '';

    return DateFormat.yMMMMd().format(createdAt!);
  }
}
