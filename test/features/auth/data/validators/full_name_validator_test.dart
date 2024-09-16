import 'package:faker/faker.dart';
import 'package:flex_workout_mobile/features/auth/data/validators/full_name_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

void main() {
  group('FullNameValidator', () {
    group('validate', () {
      test('should return null when the value is null', () {
        final mockValue = FormControl<String>(
          validators: [const FullNameValidator()],
        );

        expect(mockValue.valid, true);
      });

      test('should return null when the value is empty', () {
        final mockValue = FormControl<String>(
          value: '',
          validators: [const FullNameValidator()],
        );

        expect(mockValue.valid, true);
      });

      test('should return null when the value has extra spaces', () {
        final mockValue = FormControl<String>(
          value: '    ',
          validators: [const FullNameValidator()],
        );

        expect(mockValue.valid, true);
      });

      test('should return invalidName when there is only one word', () {
        final mockValue = FormControl<String>(
          value: 'First',
          validators: [const FullNameValidator()],
        );

        expect(mockValue.valid, false);
        expect(mockValue.hasError('invalidName'), true);
      });

      test('should return null when there are more than one word', () {
        final mockValue = FormControl<String>(
          value: '${faker.person.firstName()} ${faker.person.lastName()}',
          validators: [const FullNameValidator()],
        );

        expect(mockValue.valid, true);
      });
    });
  });
}
