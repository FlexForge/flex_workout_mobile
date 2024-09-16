import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flex_workout_mobile/features/auth/controllers/user_info_controller.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils.dart';
import '../_stores/user_model_store.dart';

void main() {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  ProviderContainer createUserContainer() {
    return createContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(mockUserRepository),
      ],
    );
  }

  group('UserInfoController', () {
    group('build', () {
      test('should return user on call', () {
        final expected = UserModelGenerator.single();

        when(
          () => mockUserRepository.getUser(),
        ).thenReturn(right(expected));

        final container = createUserContainer();
        final res = container.read(userInfoControllerProvider);

        expect(res, expected);
      });

      test('should throw error on repository error', () {
        when(
          () => mockUserRepository.getUser(),
        ).thenReturn(left(const Failure.internalServerError(message: 'Error')));

        final container = createUserContainer();

        try {
          container.read(userInfoControllerProvider);
        } catch (e) {
          expect(e.toString(), 'Failure.internalServerError(message: Error)');
        }
      });
    });
  });
}
