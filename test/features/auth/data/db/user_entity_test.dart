import 'package:flex_workout_mobile/features/auth/data/db/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_stores/user_store.dart';

void main() {
  group('UserEntity', () {
    test('toModel', () {
      final entity = UserEntityGenerator.single();
      final res = entity.toModel();

      expect(res.firstName, entity.firstName);
      expect(res.lastName, entity.lastName);
      expect(res.email, entity.email);
      expect(res.id, entity.id);
      expect(res.isMale, entity.isMale);
      expect(res.preferredTheme, entity.preferredTheme);
      expect(res.userName, entity.userName);
      expect(res.birthDate, entity.birthDate);
      expect(res.updatedAt, entity.updatedAt);
      expect(res.createdAt, entity.createdAt);
    });
  });
}
