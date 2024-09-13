import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flex_workout_mobile/features/auth/ui/containers/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() async {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  group('displays user information', () {
    testWidgets('exists', (tester) async {
      final firstName = faker.person.firstName();
      final lastName = faker.person.lastName();
      final isMale = faker.randomGenerator.boolean();
      final email = faker.internet.email();
      final birthDate = faker.date.dateTime();

      final user = UserModel(
        id: faker.randomGenerator.integer(9999),
        firstName: firstName,
        lastName: lastName,
        email: email,
        isMale: isMale,
        birthDate: birthDate,
        preferredTheme: ThemeMode.system,
        createdAt: DateTime.now(),
      );

      when(
        () => mockUserRepository.getUser(),
      ).thenReturn(right(user));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userRepositoryProvider.overrideWithValue(mockUserRepository),
          ],
          child: const WidgetWrapper(child: UserInfoCard()),
        ),
      );

      final initialsFinder = find.text('${firstName[0]}${lastName[0]}');
      final nameFinder = find.text('$firstName $lastName');
      final joinedFinder =
          find.text('Member since ${user.formatCreatedDate()}');

      expect(nameFinder, findsOneWidget);
      expect(initialsFinder, findsOneWidget);
      expect(joinedFinder, findsOneWidget);
    });
  });
}
