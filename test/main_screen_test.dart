import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_morph_ui/app.dart';
import 'package:liquid_morph_ui/glass_morphism_ui.dart';
import 'package:liquid_morph_ui/liquid_glass_ui.dart';
import 'package:liquid_morph_ui/main_home_screen.dart';

void main() {
  group('MainHomeScreen & MyApp Widget Tests', () {
    testWidgets('Renders MyApp and displays main title and showcase subtitle', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Glass UI Showcase'), findsOneWidget);
      expect(
        find.text('Select an interface design style below to preview'),
        findsOneWidget,
      );
      expect(find.text('Glassmorphism UI'), findsOneWidget);
      expect(find.text('Liquid Glass UI'), findsOneWidget);
    });

    testWidgets('Tapping Glassmorphism UI card navigates to GlassmorphismUI screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final glassmorphismCard = find.text('Glassmorphism UI');
      expect(glassmorphismCard, findsOneWidget);

      await tester.tap(glassmorphismCard);
      await tester.pumpAndSettle();

      expect(find.byType(GlassmorphismUI), findsOneWidget);
      expect(find.text('Home Screen'), findsOneWidget);

      // Tap back button
      final backButton = find.byIcon(Icons.arrow_back_ios_new);
      expect(backButton, findsOneWidget);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.byType(MainHomeScreen), findsOneWidget);
    });

    testWidgets('Tapping Liquid Glass UI card navigates to LiquidGlassUI screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final liquidGlassCard = find.text('Liquid Glass UI');
      expect(liquidGlassCard, findsOneWidget);

      await tester.tap(liquidGlassCard);
      await tester.pumpAndSettle();

      expect(find.byType(LiquidGlassUI), findsOneWidget);
      expect(find.text('Home Screen'), findsOneWidget);

      // Tap back button
      final backButton = find.byIcon(Icons.arrow_back_ios_new);
      expect(backButton, findsOneWidget);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.byType(MainHomeScreen), findsOneWidget);
    });
  });
}
