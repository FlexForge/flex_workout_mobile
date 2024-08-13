import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/auth/data/models/user_model.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flex_workout_mobile/features/auth/ui/containers/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() async {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  ProviderContainer createUserInfoContainer() {
    return createContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(mockUserRepository),
      ],
    );
  }

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
      );

      when(
        () => mockUserRepository.getUser(),
      ).thenReturn(right(user));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userRepositoryProvider.overrideWithValue(mockUserRepository),
          ],
          child: const WidgetWrapper(child: Profile()),
        ),
      );

      final nameFinder = find.text('$firstName $lastName');
      final emailFinder = find.text(email);
      final sexFinder = find.text('Male');
      final birthFinder = find.text(DateFormat.yMMMMd().format(birthDate));

      expect(nameFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(sexFinder, isMale ? findsOneWidget : findsNothing);
      expect(birthFinder, findsOneWidget);
    });
  });
}
