import 'package:flex_workout_mobile/core/common/ui/components/large_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils.dart';

void main() {
  group('LargeButton', () {
    testWidgets('renders label and icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        WidgetWrapper(
          child: LargeButton(
            label: 'Button',
            icon: Icons.add,
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Button'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders child widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        WidgetWrapper(
          child: LargeButton(
            child: const Text('Custom Widget'),
            onPressed: () {},
          ),
        ),
      );

      expect(find.text('Custom Widget'), findsOneWidget);
    });

    testWidgets('calls onPressed when button is pressed',
        (WidgetTester tester) async {
      var onPressedCalled = false;

      await tester.pumpWidget(
        WidgetWrapper(
          child: LargeButton(
            label: 'Button',
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      );

      await tester.tap(find.text('Button'));
      await tester.pump();

      expect(onPressedCalled, true);
    });

    testWidgets('disables button when enabled is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        WidgetWrapper(
          child: LargeButton(
            label: 'Button',
            enabled: false,
            onPressed: () {},
          ),
        ),
      );

      final button = tester.widget<TextButton>(find.byType(TextButton));
      expect(button.enabled, false);
    });
  });
}
