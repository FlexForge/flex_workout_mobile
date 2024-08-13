import 'package:flex_workout_mobile/core/common/ui/components/flex_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

MaterialApp _buildAppWithDialog({
  String? title,
  String? description,
  Widget? child,
  void Function()? onPressed,
  String? actionLabel,
  String? cancelLabel,
}) {
  return MaterialApp(
    home: Material(
      child: Builder(
        builder: (BuildContext context) {
          return Center(
            child: ElevatedButton(
              child: const Text('X'),
              onPressed: () {
                showFlexAlertDialog(
                  context,
                  title: title,
                  description: description,
                  child: child,
                  onPressed: onPressed,
                  actionLabel: actionLabel,
                  cancelLabel: cancelLabel,
                );
              },
            ),
          );
        },
      ),
    ),
  );
}

void main() async {
  group('flex_alert_dialog', () {
    testWidgets('default', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_buildAppWithDialog());

        await tester.tap(find.text('X'));
        await tester.pumpAndSettle();

        final cancelFinder = find.text('Cancel');
        final confirmFinder = find.text('Confirm');
        final titleFinder = find.text('Title');
        final descriptionFinder = find.text('Description');
        final childFinder = find.text('Child');

        expect(cancelFinder, findsOneWidget);
        expect(confirmFinder, findsOneWidget);
        expect(titleFinder, findsNothing);
        expect(descriptionFinder, findsNothing);
        expect(childFinder, findsNothing);
      });
    });

    testWidgets('shows title', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_buildAppWithDialog(title: 'Title'));

        await tester.tap(find.text('X'));
        await tester.pumpAndSettle();

        final titleFinder = find.text('Title');
        final cancelFinder = find.text('Cancel');
        final confirmFinder = find.text('Confirm');
        final descriptionFinder = find.text('Description');
        final childFinder = find.text('Child');

        expect(cancelFinder, findsOneWidget);
        expect(confirmFinder, findsOneWidget);
        expect(descriptionFinder, findsNothing);
        expect(childFinder, findsNothing);
        expect(titleFinder, findsOneWidget);
      });
    });

    testWidgets('shows description', (tester) async {
      await tester.runAsync(() async {
        await tester
            .pumpWidget(_buildAppWithDialog(description: 'Description'));

        await tester.tap(find.text('X'));
        await tester.pumpAndSettle();

        final descriptionFinder = find.text('Description');
        final cancelFinder = find.text('Cancel');
        final confirmFinder = find.text('Confirm');
        final titleFinder = find.text('Title');
        final childFinder = find.text('Child');

        expect(cancelFinder, findsOneWidget);
        expect(confirmFinder, findsOneWidget);
        expect(titleFinder, findsNothing);
        expect(childFinder, findsNothing);
        expect(descriptionFinder, findsOneWidget);
      });
    });

    testWidgets('shows child', (tester) async {
      await tester.runAsync(() async {
        await tester
            .pumpWidget(_buildAppWithDialog(child: const Text('Child')));

        await tester.tap(find.text('X'));
        await tester.pumpAndSettle();

        final childFinder = find.text('Child');
        final cancelFinder = find.text('Cancel');
        final confirmFinder = find.text('Confirm');
        final titleFinder = find.text('Title');
        final descriptionFinder = find.text('Description');

        expect(cancelFinder, findsOneWidget);
        expect(confirmFinder, findsOneWidget);
        expect(titleFinder, findsNothing);
        expect(descriptionFinder, findsNothing);
        expect(childFinder, findsOneWidget);
      });
    });

    testWidgets('shows actionLabel', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_buildAppWithDialog(actionLabel: 'Action'));

        await tester.tap(find.text('X'));
        await tester.pumpAndSettle();

        final actionFinder = find.text('Action');
        final cancelFinder = find.text('Cancel');
        final titleFinder = find.text('Title');
        final descriptionFinder = find.text('Description');
        final childFinder = find.text('Child');

        expect(cancelFinder, findsOneWidget);
        expect(titleFinder, findsNothing);
        expect(descriptionFinder, findsNothing);
        expect(childFinder, findsNothing);
        expect(actionFinder, findsOneWidget);
      });
    });

    testWidgets('shows cancelLabel', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_buildAppWithDialog(cancelLabel: 'Stop'));

        await tester.tap(find.text('X'));
        await tester.pumpAndSettle();

        final cancelFinder = find.text('Stop');
        final confirmFinder = find.text('Confirm');
        final titleFinder = find.text('Title');
        final descriptionFinder = find.text('Description');
        final childFinder = find.text('Child');

        expect(confirmFinder, findsOneWidget);
        expect(titleFinder, findsNothing);
        expect(descriptionFinder, findsNothing);
        expect(childFinder, findsNothing);
        expect(cancelFinder, findsOneWidget);
      });
    });
  });
}
