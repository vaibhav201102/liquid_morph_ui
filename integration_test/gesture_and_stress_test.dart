import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_bottom_bar_ui/app.dart';
import 'package:glass_bottom_bar_ui/glass_morphism_ui.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runGestureAndStressTests();
}

void runGestureAndStressTests() {
  group('Advanced Gesture, Layout & Edge Case Integration Tests', () {
    testWidgets('Screen Re-entry Clean State Initialization Test', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // 1. Enter Liquid Glass UI, select Profile tab (index 3)
      await tester.tap(find.byKey(const ValueKey('liquid_glass_card_button')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('liquid_tab_item_3')));
      await tester.pumpAndSettle();
      expect(find.text('Profile Screen'), findsOneWidget);

      // Pop back to home
      await tester.tap(find.byKey(const ValueKey('liquid_app_bar_back_button')));
      await tester.pumpAndSettle();

      // Re-enter Liquid Glass UI -> Must start on Home Screen (index 0)
      await tester.tap(find.byKey(const ValueKey('liquid_glass_card_button')));
      await tester.pumpAndSettle();

      expect(find.text('Home Screen'), findsOneWidget);

      // Clean pop
      await tester.tap(find.byKey(const ValueKey('liquid_app_bar_back_button')));
      await tester.pumpAndSettle();
    });

    testWidgets('Mid-Transit Tap Interruption Test in LiquidGlassUI', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('liquid_glass_card_button')));
      await tester.pumpAndSettle();

      // Tap search tab (starts animation)
      await tester.tap(find.byKey(const ValueKey('liquid_tab_item_1')));
      await tester.pump(const Duration(milliseconds: 100)); // mid-anim tick

      // Immediately tap profile tab while mid-flight
      await tester.tap(find.byKey(const ValueKey('liquid_tab_item_3')));
      await tester.pumpAndSettle();

      expect(find.text('Profile Screen'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('liquid_app_bar_back_button')));
      await tester.pumpAndSettle();
    });

    testWidgets('Out-of-Bounds Horizontal Drag Clamping Test', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('liquid_glass_card_button')));
      await tester.pumpAndSettle();

      final navBar = find.byKey(const ValueKey('liquid_bottom_nav_bar_gesture'));

      // Extreme left out-of-bounds drag
      await tester.drag(navBar, const Offset(-1000.0, 0.0));
      await tester.pumpAndSettle();

      expect(find.text('Home Screen'), findsOneWidget);

      // Extreme right out-of-bounds drag
      await tester.drag(navBar, const Offset(2000.0, 0.0));
      await tester.pumpAndSettle();

      expect(find.text('Profile Screen'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('liquid_app_bar_back_button')));
      await tester.pumpAndSettle();
    });

    testWidgets('Gesture Drag Cancel Test during Active Gesture', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('glassmorphism_card_button')));
      await tester.pumpAndSettle();

      final gesture = await tester.startGesture(const Offset(100, 700));
      await gesture.moveBy(const Offset(100, 0));
      await gesture.cancel();
      await tester.pumpAndSettle();

      expect(find.byType(GlassmorphismUI), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('glass_app_bar_back_button')));
      await tester.pumpAndSettle();
    });

    testWidgets('Tablet & Wide Screen Viewport Adaptability Test', (
      WidgetTester tester,
    ) async {
      // Simulate tablet wide-screen view size
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Glass UI Showcase'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('liquid_glass_card_button')));
      await tester.pumpAndSettle();

      expect(find.text('Liquid Glass UI'), findsOneWidget);
      expect(find.text('Home Screen'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('liquid_tab_item_1')));
      await tester.pumpAndSettle();
      expect(find.text('Search Screen'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('liquid_app_bar_back_button')));
      await tester.pumpAndSettle();

      // Reset view size
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });
  });
}
