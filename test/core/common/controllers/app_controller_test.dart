import 'package:flex_workout_mobile/core/common/controllers/app_controller.dart';
import 'package:flex_workout_mobile/core/common/data/models/app_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils.dart';

void main() {
  ProviderContainer createAppContainer() {
    return createContainer();
  }

  group('AppController', () {
    group('build', () {
      test('returns a AppModel', () {
        final ref = createAppContainer();
        final controller = ref.read(appControllerProvider);

        expect(controller, isA<AppModel>());
      });
    });

    group('startWorkout', () {
      test('sets workoutInProgress to true', () {
        final ref = createAppContainer();
        ref.read(appControllerProvider.notifier).startWorkout();
        final controller = ref.read(appControllerProvider);

        expect(controller.workoutInProgress, true);
      });
    });

    group('endWorkout', () {
      test('sets workoutInProgress to false', () {
        final ref = createAppContainer();
        ref.read(appControllerProvider.notifier).endWorkout();
        final controller = ref.read(appControllerProvider);

        expect(controller.workoutInProgress, false);
      });
    });
  });
}
