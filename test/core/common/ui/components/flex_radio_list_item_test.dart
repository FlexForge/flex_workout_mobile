import 'package:flex_workout_mobile/core/common/ui/components/flex_radio_list_item.dart';
import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils.dart';

void main() {
  group('RadioListItem', () {
    testWidgets('renders correctly when selected is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        WidgetWrapper(
          child: RadioListItem(
            name: 'Item 1',
            icon: Icons.check,
            selected: true,
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(LargeButton), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('renders correctly when selected is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        WidgetWrapper(
          child: RadioListItem(
            name: 'Item 2',
            icon: Icons.check,
            onPressed: () {},
          ),
        ),
      );

      expect(find.byType(LargeButton), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('calls onPressed when button is pressed',
        (WidgetTester tester) async {
      var onPressedCalled = false;

      await tester.pumpWidget(
        WidgetWrapper(
          child: RadioListItem(
            name: 'Item 3',
            icon: Icons.check,
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      );

      await tester.tap(find.byType(LargeButton));
      await tester.pump();

      expect(onPressedCalled, true);
    });
  });
}
