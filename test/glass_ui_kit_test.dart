import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_bottom_bar_ui/glass_ui_kit.dart';

void main() {
  group('GlassUIKit Extension & Container Tests', () {
    testWidgets('Renders GlassContainer wrapping child content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GlassContainer(
                child: Text('Frosted Content'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Frosted Content'), findsOneWidget);
      expect(find.byType(GlassContainer), findsOneWidget);
    });

    testWidgets('Renders LiquidGlassContainer wrapping child content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: LiquidGlassContainer(
                child: Text('Liquid Content'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Liquid Content'), findsOneWidget);
      expect(find.byType(LiquidGlassContainer), findsOneWidget);
    });

    testWidgets('Applies .asGlass() widget extension method successfully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: const Text('Extension Glass Text').asGlass(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Extension Glass Text'), findsOneWidget);
      expect(find.byType(GlassContainer), findsOneWidget);
    });

    testWidgets('Applies .asLiquidGlass() widget extension method successfully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: const Text('Extension Liquid Text').asLiquidGlass(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Extension Liquid Text'), findsOneWidget);
      expect(find.byType(LiquidGlassContainer), findsOneWidget);
    });
  });
}
