import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_glass_ui/glass_ui_kit.dart';

void main() {
  group('GlassUIKit Extension, Container & AppBar Tests', () {
    testWidgets('Renders GlassContainer wrapping child content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GlassContainer(
                child: const Text('Frosted Content'),
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
                child: const Text('Liquid Content'),
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

    testWidgets('Renders standalone GlassAppBar with custom title, leftButtons and rightButtons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: GlassAppBar(
              title: 'Custom Title',
              leftButtons: const [
                Icon(Icons.menu, key: ValueKey('left_menu_icon')),
              ],
              rightButtons: const [
                Icon(Icons.search, key: ValueKey('right_search_icon')),
              ],
            ),
            body: const Center(child: Text('Content')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Custom Title'), findsOneWidget);
      expect(find.byKey(const ValueKey('left_menu_icon')), findsOneWidget);
      expect(find.byKey(const ValueKey('right_search_icon')), findsOneWidget);
    });

    testWidgets('Renders standalone GlassAppBar.liquid with fluid styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: GlassAppBar.liquid(
              title: 'Liquid Title',
              rightButtons: const [
                Icon(Icons.settings, key: ValueKey('liquid_settings_icon')),
              ],
            ),
            body: const Center(child: Text('Content')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Liquid Title'), findsOneWidget);
      expect(find.byKey(const ValueKey('liquid_settings_icon')), findsOneWidget);
    });
  });
}
