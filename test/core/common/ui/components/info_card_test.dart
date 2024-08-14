import 'package:flex_workout_mobile/core/common/ui/components/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils.dart';

void main() {
  group('InfoCard', () {
    testWidgets('renders icon and info text', (WidgetTester tester) async {
      const icon = Icons.info;
      const info = 'This is some information';

      await tester.pumpWidget(
        const WidgetWrapper(
          child: InfoCard(
            icon: icon,
            info: info,
          ),
        ),
      );

      expect(find.byIcon(icon), findsOneWidget);
      expect(find.text(info), findsOneWidget);
    });

    testWidgets('renders with custom background color',
        (WidgetTester tester) async {
      const backgroundColor = Colors.blue;
      const icon = Icons.info;
      const info = 'This is some information';

      await tester.pumpWidget(
        const WidgetWrapper(
          child: InfoCard(
            icon: icon,
            info: info,
            backgroundColor: backgroundColor,
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, equals(backgroundColor));
    });

    testWidgets('renders with custom border color and width',
        (WidgetTester tester) async {
      const borderColor = Colors.red;
      const borderWidth = 4.0;
      const icon = Icons.info;
      const info = 'This is some information';

      await tester.pumpWidget(
        const WidgetWrapper(
          child: InfoCard(
            icon: icon,
            info: info,
            borderColor: borderColor,
            borderWidth: borderWidth,
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.border?.top.color, equals(borderColor));
      expect(decoration.border?.top.width, equals(borderWidth));
    });
  });
}
