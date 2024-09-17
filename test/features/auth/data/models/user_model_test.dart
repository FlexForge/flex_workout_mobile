import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_stores/user_store.dart';

void main() {
  group('UserModel', () {
    test('toEntity', () {
      final model = UserModelGenerator.single();
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
      final model = UserModelGenerator.single(createdAt: DateTime(2024, 2, 2));

      test('date is null', () {
        final noDateModel = model.copyWith(createdAt: null);
        final formattedDate = noDateModel.formatCreatedDate();

        expect(formattedDate, '');
      });

      test('date is not null', () {
        final formattedDate = model.formatCreatedDate();

        expect(formattedDate, 'February 2, 2024');
      });
    });
  });
}
