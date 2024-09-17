import 'package:flex_workout_mobile/core/utils/functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('lbsToKgs', () {
    test('1 lbs to kgs', () {
      const lbs = 1.0;
      final kgs = lbsToKgs(lbs);
      expect(kgs, 0.4535924);
    });

    test('10 lbs to kgs', () {
      const lbs = 10.0;
      final kgs = lbsToKgs(lbs);
      expect(kgs, 4.535924);
    });
  });

  group(
    'kgsToLbs',
    () {
      test('1 kgs to lbs', () {
        const kgs = 1.0;
        final lbs = kgsToLbs(kgs);
        expect(lbs, 2.204623);
      });

      test('10 kgs to lbs', () {
        const kgs = 10.0;
        final lbs = kgsToLbs(kgs);
        expect(lbs, 22.04623);
      });
    },
  );
}
