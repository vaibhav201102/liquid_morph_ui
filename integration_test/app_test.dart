import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_morph_ui/app.dart';
import 'package:liquid_morph_ui/glass_morphism_ui.dart';
import 'package:liquid_morph_ui/liquid_glass_ui.dart';
import 'package:liquid_morph_ui/main_home_screen.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runAppTests();
}

void runAppTests() {
  group('Full Application End-to-End Integration Tests', () {
    testWidgets('Complete Glassmorphism UI Journey: Launch, Tab Switching, Drag, Back Navigation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // 1. Verify Home Screen loaded
      expect(find.text('Glass UI Showcase'), findsOneWidget);
      expect(find.byKey(const ValueKey('glassmorphism_card_button')), findsOneWidget);

      // 2. Navigate to Glassmorphism UI
      await tester.tap(find.byKey(const ValueKey('glassmorphism_card_button')));
      await tester.pumpAndSettle();

      expect(find.byType(GlassmorphismUI), findsOneWidget);
      expect(find.text('Home Screen'), findsOneWidget);

      // 3. Tab Navigation using explicit tab keys
      await tester.tap(find.byKey(const ValueKey('glass_tab_item_1')));
      await tester.pumpAndSettle();
      expect(find.text('Search Screen'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('glass_tab_item_2')));
      await tester.pumpAndSettle();
      expect(find.text('Favorites Screen'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('glass_tab_item_3')));
      await tester.pumpAndSettle();
      expect(find.text('Profile Screen'), findsOneWidget);

      // 4. Drag Gesture Navigation
      final navBar = find.byKey(const ValueKey('glass_bottom_nav_bar_gesture'));
      expect(navBar, findsOneWidget);
      await tester.drag(navBar, const Offset(-200.0, 0.0));
      await tester.pumpAndSettle();

      // 5. Back Navigation
      final backButton = find.byKey(const ValueKey('glass_app_bar_back_button'));
      expect(backButton, findsOneWidget);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.byType(MainHomeScreen), findsOneWidget);
    });

    testWidgets('Complete Liquid Glass UI Journey: Launch, Spring Transitions, Fluid Drag, Back Navigation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // 1. Verify Home Screen loaded
      expect(find.text('Glass UI Showcase'), findsOneWidget);
      expect(find.byKey(const ValueKey('liquid_glass_card_button')), findsOneWidget);

      // 2. Navigate to Liquid Glass UI
      await tester.tap(find.byKey(const ValueKey('liquid_glass_card_button')));
      await tester.pumpAndSettle();

      expect(find.byType(LiquidGlassUI), findsOneWidget);
      expect(find.text('Fluid'), findsOneWidget);
      expect(find.text('Home Screen'), findsOneWidget);

      // 3. Spring Tab Transitions using explicit tab keys
      await tester.tap(find.byKey(const ValueKey('liquid_tab_item_1')));
      await tester.pumpAndSettle();
      expect(find.text('Search Screen'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('liquid_tab_item_2')));
      await tester.pumpAndSettle();
      expect(find.text('Favorites Screen'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('liquid_tab_item_3')));
      await tester.pumpAndSettle();
      expect(find.text('Profile Screen'), findsOneWidget);

      // 4. Fluid Drag Gesture
      final liquidNavBar = find.byKey(const ValueKey('liquid_bottom_nav_bar_gesture'));
      expect(liquidNavBar, findsOneWidget);
      await tester.drag(liquidNavBar, const Offset(-220.0, 0.0));
      await tester.pumpAndSettle();

      // 5. Back Navigation via Liquid Glass AppBar back button
      final circularBackButton = find.byKey(const ValueKey('liquid_app_bar_back_button'));
      expect(circularBackButton, findsOneWidget);
      await tester.tap(circularBackButton);
      await tester.pumpAndSettle();

      expect(find.byType(MainHomeScreen), findsOneWidget);
    });

    testWidgets('Rapid Multi-Navigation & Stress Interactivity Test', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Rapidly toggle between screens
      for (int i = 0; i < 2; i++) {
        await tester.tap(find.byKey(const ValueKey('glassmorphism_card_button')));
        await tester.pumpAndSettle();
        expect(find.byType(GlassmorphismUI), findsOneWidget);

        await tester.tap(find.byKey(const ValueKey('glass_app_bar_back_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const ValueKey('liquid_glass_card_button')));
        await tester.pumpAndSettle();
        expect(find.byType(LiquidGlassUI), findsOneWidget);

        // Rapid tab clicks inside Liquid Glass UI
        await tester.tap(find.byKey(const ValueKey('liquid_tab_item_1')));
        await tester.pump(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const ValueKey('liquid_tab_item_2')));
        await tester.pump(const Duration(milliseconds: 50));
        await tester.tap(find.byKey(const ValueKey('liquid_tab_item_3')));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const ValueKey('liquid_app_bar_back_button')));
        await tester.pumpAndSettle();
      }

      expect(find.byType(MainHomeScreen), findsOneWidget);
    });
  });
}
