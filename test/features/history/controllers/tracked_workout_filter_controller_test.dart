import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/history/controllers/tracked_workout_filter_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_old/utils.dart';

void main() {
  ProviderContainer createFilterContainer() {
    return createContainer();
  }

  group('TrackedWorkoutFilterController', () {
    group('build', () {
      test('should return null', () {
        final ref = createFilterContainer();
        final res = ref.read(trackedWorkoutFilterControllerProvider);

        expect(res, null);
      });
    });

    group('handle', () {
      test('should update state to filter', () {
        final dateTime = faker.date.dateTime();

        final ref = createFilterContainer();
        ref
            .read(trackedWorkoutFilterControllerProvider.notifier)
            .handle(dateTime);

        final res = ref.read(trackedWorkoutFilterControllerProvider);

        expect(dateTime, res);
      });
    });
  });
}
