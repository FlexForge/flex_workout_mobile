import 'package:flex_workout_mobile/core/common/ui/components/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils.dart';

void main() {
  group('Section', () {
    testWidgets('renders header and body correctly',
        (WidgetTester tester) async {
      const headerText = 'Header';
      const bodyText = 'Body';

      await tester.pumpWidget(
        const WidgetWrapper(
          child: Section(
            header: headerText,
            body: Text(bodyText),
          ),
        ),
      );

      expect(find.text(headerText), findsOneWidget);
      expect(find.text(bodyText), findsOneWidget);
    });

    testWidgets('renders subHeader correctly', (WidgetTester tester) async {
      const subHeaderText = 'Sub Header';

      await tester.pumpWidget(
        WidgetWrapper(
          child: Section(
            subHeader: subHeaderText,
            body: Container(),
          ),
        ),
      );

      expect(find.text(subHeaderText), findsOneWidget);
    });

    testWidgets('renders with custom background color',
        (WidgetTester tester) async {
      const backgroundColor = Colors.blue;

      await tester.pumpWidget(
        const WidgetWrapper(
          child: Section(
            backgroundColor: backgroundColor,
            body: Text('test'),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, equals(backgroundColor));
    });
  });
}
