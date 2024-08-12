import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/db/objectbox.g.dart' as ob;
import 'package:flex_workout_mobile/features/auth/data/db/user_entity.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class UserRepository {
  UserRepository({required this.store});

  final ob.Store store;

  ob.Box<User> get box => store.box<User>();

  Either<Failure, UserModel> getUser() {
    try {
      final res = box.getAll();

      if (res.isEmpty) {
        return left(const Failure.empty());
      }

      return right(res.first.toModel());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }

  Either<Failure, UserModel> createUser({
    required String firstName,
    required String lastName,
    required String email,
    required bool isMale,
  }) {
    try {
      final userToAdd = User(
        firstName,
        lastName,
        email,
        isMale: isMale,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final id = box.put(userToAdd);

      final res = box.get(id);

      if (res == null) {
        return left(
          const Failure.internalServerError(
            message: 'Unable to fetch new post',
          ),
        );
      }

      return right(res.toModel());
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }

  Either<Failure, ThemeMode> updateTheme({
    required ThemeMode theme,
  }) {
    try {
      final res = box.getAll();

      if (res.isEmpty) {
        return left(const Failure.empty());
      }

      final user = res.first;

      box.put(
        user..dbPreferredTheme = theme.index,
        mode: ob.PutMode.update,
      );

      return right(theme);
    } catch (e) {
      return left(Failure.internalServerError(message: e.toString()));
    }
  }
}
