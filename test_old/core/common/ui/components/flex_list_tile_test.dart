import 'package:flex_workout_mobile/core/common/ui/components/flex_list_tile.dart';
import 'package:flex_workout_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils.dart';

const _nonDisabledState = {
  WidgetState.selected,
  WidgetState.dragged,
  WidgetState.error,
  WidgetState.focused,
  WidgetState.hovered,
  WidgetState.pressed,
  WidgetState.scrolledUnder,
};

void main() async {
  group('FlexListTile', () {
    group('colors', () {
      testWidgets('default', (tester) async {
        await tester.pumpWidget(
          const WidgetWrapper(
            child: FlexListTile(
              title: Text('Title'),
            ),
          ),
        );

        final listTile = tester.widget<TextButton>(find.byType(TextButton));

        expect(
          listTile.style!.foregroundColor?.resolve(_nonDisabledState),
          AppColors.lightModeColors.foregroundPrimary,
        );
        expect(
          listTile.style!.foregroundColor?.resolve({WidgetState.disabled}),
          AppColors.lightModeColors.foregroundSecondary,
        );
      });

      testWidgets('user input', (tester) async {
        await tester.pumpWidget(
          WidgetWrapper(
            child: FlexListTile(
              title: const Text('Title'),
              foregroundColor: AppColors.lightModeColors.backgroundPrimary,
              disabledForegroundColor:
                  AppColors.lightModeColors.backgroundSecondary,
              backgroundColor: AppColors.lightModeColors.foregroundPrimary,
            ),
          ),
        );

        final listTile = tester.widget<TextButton>(find.byType(TextButton));

        expect(
          listTile.style!.foregroundColor?.resolve(_nonDisabledState),
          AppColors.lightModeColors.backgroundPrimary,
        );
        expect(
          listTile.style!.foregroundColor?.resolve({WidgetState.disabled}),
          AppColors.lightModeColors.backgroundSecondary,
        );
        expect(
          listTile.style!.backgroundColor?.resolve(_nonDisabledState),
          AppColors.lightModeColors.foregroundPrimary,
        );
      });
    });

    group('suffix and prefix', () {
      testWidgets('exists', (tester) async {
        await tester.pumpWidget(
          const WidgetWrapper(
            child: FlexListTile(
              title: Text('Title'),
              suffix: Text('Suffix'),
              prefix: Text('Prefix'),
            ),
          ),
        );

        final suffixFinder = find.text('Suffix');
        final prefixFinder = find.text('Prefix');

        expect(suffixFinder, findsOneWidget);
        expect(prefixFinder, findsOneWidget);
      });

      testWidgets('default', (tester) async {
        await tester.pumpWidget(
          const WidgetWrapper(
            child: FlexListTile(
              title: Text('Title'),
            ),
          ),
        );

        final suffixFinder = find.text('Suffix');
        final prefixFinder = find.text('Prefix');

        expect(suffixFinder, findsNothing);
        expect(prefixFinder, findsNothing);
      });
    });

    group('icons', () {
      testWidgets('exists', (tester) async {
        await tester.pumpWidget(
          const WidgetWrapper(
            child: FlexListTile(
              title: Text('Title'),
              icon: Icons.ac_unit,
              trailingIcon: Icons.access_alarm,
            ),
          ),
        );

        final iconFinder = find.byIcon(Icons.ac_unit);
        final trailingIconFinder = find.byIcon(Icons.access_alarm);

        expect(iconFinder, findsOneWidget);
        expect(trailingIconFinder, findsOneWidget);
      });

      testWidgets('default', (tester) async {
        await tester.pumpWidget(
          const WidgetWrapper(
            child: FlexListTile(
              title: Text('Title'),
            ),
          ),
        );

        final iconFinder = find.byIcon(Icons.ac_unit);
        final trailingIconFinder = find.byIcon(Icons.access_alarm);

        expect(iconFinder, findsNothing);
        expect(trailingIconFinder, findsNothing);
      });
    });

    group('titles', () {
      testWidgets('exists', (tester) async {
        await tester.pumpWidget(
          const WidgetWrapper(
            child: FlexListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
          ),
        );

        final titleFinder = find.text('Title');
        final subtitleFinder = find.text('Subtitle');

        expect(titleFinder, findsOneWidget);
        expect(subtitleFinder, findsOneWidget);
      });

      testWidgets('default', (tester) async {
        await tester.pumpWidget(
          const WidgetWrapper(
            child: FlexListTile(
              title: Text('Title'),
            ),
          ),
        );

        final titleFinder = find.text('Title');
        final subtitleFinder = find.text('Subtitle');

        expect(titleFinder, findsOneWidget);
        expect(subtitleFinder, findsNothing);
      });
    });

    testWidgets('actionButtons', (tester) async {
      await tester.pumpWidget(
        WidgetWrapper(
          child: FlexListTile(
            title: const Text('Title'),
            actionButtons: [
              TextButton(
                onPressed: () {},
                child: const Text('Button 1'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Button 2'),
              ),
            ],
          ),
        ),
      );

      final button1Finder = find.text('Button 1');
      final button2Finder = find.text('Button 2');

      expect(button1Finder, findsOneWidget);
      expect(button2Finder, findsOneWidget);
    });

    testWidgets('onTap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        WidgetWrapper(
          child: FlexListTile(
            title: const Text('Title'),
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });
  });
}
