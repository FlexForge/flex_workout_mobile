import 'package:flex_workout_mobile/core/common/ui/components/segment_controller.dart';
import 'package:flex_workout_mobile/core/theme/app_colors.dart';
import 'package:flex_workout_mobile/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils.dart';

void main() {
  group('SegmentedController', () {
    const items = <String>['Item 1', 'Item 2', 'Item 3'];
    const initialValue = 1;
    var selectedValue = initialValue;

    void onValueChanged(int value) {
      selectedValue = value;
    }

    testWidgets('Should render the correct number of items',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        WidgetWrapper(
          child: SegmentedController(
            selectedValue: selectedValue,
            onValueChanged: onValueChanged,
            items: items,
          ),
        ),
      );

      final item1Finder = find.text(items[0]);
      final item2Finder = find.text(items[1]);
      final item3Finder = find.text(items[2]);

      expect(item1Finder, findsOneWidget);
      expect(item2Finder, findsOneWidget);
      expect(item3Finder, findsOneWidget);
    });

    testWidgets('Should update the selected value when an item is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        WidgetWrapper(
          child: SegmentedController(
            selectedValue: selectedValue,
            onValueChanged: onValueChanged,
            items: items,
          ),
        ),
      );

      final item1Finder = find.text(items[0]);
      final item2Finder = find.text(items[1]);
      final item3Finder = find.text(items[2]);

      await tester.tap(item3Finder);
      await tester.pump();

      expect(selectedValue, 2);

      await tester.tap(item1Finder);
      await tester.pump();

      expect(selectedValue, 0);

      await tester.tap(item2Finder);
      await tester.pump();

      expect(selectedValue, 1);
    });

    testWidgets('Should apply the correct styles to the selected item',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        WidgetWrapper(
          child: SegmentedController(
            selectedValue: selectedValue,
            onValueChanged: onValueChanged,
            items: items,
          ),
        ),
      );

      final item1Finder = find.text(items[0]);
      final item2Finder = find.text(items[1]);
      final item3Finder = find.text(items[2]);

      final selectedStyle = AppTypography.label.large.copyWith(
        color: AppColors.lightModeColors.backgroundPrimary,
      );

      final unselectedStyle = AppTypography.label.large.copyWith(
        color: AppColors.lightModeColors.foregroundPrimary,
      );

      final item1Widget = tester.widget(item1Finder) as Text;
      final item2Widget = tester.widget(item2Finder) as Text;
      final item3Widget = tester.widget(item3Finder) as Text;

      expect(item1Widget.style, unselectedStyle);
      expect(item2Widget.style, selectedStyle);
      expect(item3Widget.style, unselectedStyle);
    });
  });
}
