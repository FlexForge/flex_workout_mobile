import 'package:flex_workout_mobile/core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failure', () {
    group('get error message', () {
      test('default errors', () {
        const emptyFailure = Failure.empty();
        const unauthorizedFailure = Failure.unauthorized();
        const badRequestFailure = Failure.badRequest();

        expect(emptyFailure.error, 'Failure.empty()');
        expect(unauthorizedFailure.error, 'Failure.unauthorized()');
        expect(badRequestFailure.error, 'Failure.badRequest()');
      });

      test('unprocessableEntityFailure', () {
        const unprocessableEntityFailure =
            Failure.unprocessableEntity(message: 'message');

        expect(unprocessableEntityFailure.error, 'message');
      });

      test('internalServerErrorFailure with message', () {
        const internalServerErrorFailure =
            Failure.internalServerError(message: 'message');

        expect(internalServerErrorFailure.error, 'message');
      });

      test('internalServerErrorFailure without message', () {
        const internalServerErrorFailure = Failure.internalServerError();

        expect(
          internalServerErrorFailure.error,
          'Failure.internalServerError(message: null)',
        );
      });
    });
  });
}
