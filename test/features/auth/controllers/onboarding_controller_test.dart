import 'package:flex_workout_mobile/features/auth/controllers/onboarding_controller.dart';
import 'package:flex_workout_mobile/features/auth/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  late MockOnboardingRepository mockOnboardingRepository;

  setUp(() {
    mockOnboardingRepository = MockOnboardingRepository();
  });

  ProviderContainer createOnboardingContainer() {
    return createContainer(
      overrides: [
        onboardingRepositoryProvider
            .overrideWithValue(mockOnboardingRepository),
      ],
    );
  }

  group('OnboardingController', () {
    group('build', () {
      test('should return true if first load', () {
        when(() => mockOnboardingRepository.getIsFirstLoad())
            .thenReturn(right(true));

        final container = createOnboardingContainer();
        final res = container.read(onboardingControllerProvider);

        final loadListener = isFirstLoadListener.value;

        expect(res, true);
        expect(loadListener, true);
      });
    });

    group('setIsFirstLoad', () {
      test('should set isFirstLoad to true', () async {
        when(
          () => mockOnboardingRepository.setIsFirstLoad(isFirstLoad: true),
        ).thenAnswer((_) => Future.value(right(true)));

        final ref = createOnboardingContainer();
        await ref
            .read(onboardingControllerProvider.notifier)
            .setIsFirstLoad(isFirstLoad: true);

        final loadListener = isFirstLoadListener.value;
        final res = ref.read(onboardingControllerProvider);

        expect(res, true);
        expect(loadListener, true);
      });

      test('should set isFirstLoad to false', () async {
        when(
          () => mockOnboardingRepository.setIsFirstLoad(isFirstLoad: false),
        ).thenAnswer((_) => Future.value(right(false)));

        final ref = createOnboardingContainer();
        await ref
            .read(onboardingControllerProvider.notifier)
            .setIsFirstLoad(isFirstLoad: false);

        final loadListener = isFirstLoadListener.value;
        final res = ref.read(onboardingControllerProvider);

        expect(res, false);
        expect(loadListener, false);
      });
    });
  });
}
