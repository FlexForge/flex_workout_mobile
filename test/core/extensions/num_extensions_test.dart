import 'package:flex_workout_mobile/core/extensions/num_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CleanNumber', () {
    test('should return specified decimals when decimal is defined', () {
      const entity = 1.23456789;

      final result = entity.cleanNumber(decimal: 3);
      expect(result, '1.235');
    });
    test('should return 0 decimals when num is divisible by 1', () {
      const entity = 2.01;

      final result = entity.cleanNumber();
      expect(result, '2');
    });

    test('should return 1 decimal when num is divisible by 0.5', () {
      const entity = 1.6;

      final result = entity.cleanNumber();
      expect(result, '1.5');
    });

    test('should return 2 decimals when num is not divisible by 0.5 or 1', () {
      const entity = 1.23456789;

      final result = entity.cleanNumber();
      expect(result, '1.25');
    });
  });
}
