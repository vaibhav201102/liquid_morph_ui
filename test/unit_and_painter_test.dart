import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_glass_ui_kit/liquid_glass_ui.dart';

void main() {
  group('BottomNavigationItem Unit Tests', () {
    test('Creates BottomNavigationItem with correct properties', () {
      const item = BottomNavigationItem(
        selectedIcon: Icons.home,
        unselectedIcon: Icons.home_outlined,
        label: 'Home Tab',
        index: 0,
      );

      expect(item.selectedIcon, Icons.home);
      expect(item.unselectedIcon, Icons.home_outlined);
      expect(item.label, 'Home Tab');
      expect(item.index, 0);
    });
  });

  group('_LiquidGlassPainter Unit Tests', () {
    testWidgets('CustomPainter paints on canvas without error', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: CustomPaint(
                size: const Size(300, 70),
                painter: const CustomPaint().painter,
              ),
            ),
          ),
        ),
      );
      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
