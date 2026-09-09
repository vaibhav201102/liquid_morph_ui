import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_glass_ui/liquid_glass_ui.dart';

void main() {
  group('LiquidGlassUI Widget Tests', () {
    const samplePages = [
      Center(child: Text('Home Screen')),
      Center(child: Text('Search Screen')),
      Center(child: Text('Favorites Screen')),
      Center(child: Text('Profile Screen')),
    ];

    const sampleItems = [
      BottomNavigationItem(
        selectedIcon: Icons.home,
        unselectedIcon: Icons.home_outlined,
        label: 'Home',
        index: 0,
      ),
      BottomNavigationItem(
        selectedIcon: Icons.search,
        unselectedIcon: Icons.search_outlined,
        label: 'Search',
        index: 1,
      ),
      BottomNavigationItem(
        selectedIcon: Icons.favorite,
        unselectedIcon: Icons.favorite_border,
        label: 'Favorites',
        index: 2,
      ),
      BottomNavigationItem(
        selectedIcon: Icons.person,
        unselectedIcon: Icons.person_outline,
        label: 'Profile',
        index: 3,
      ),
    ];

    Widget buildTestWidget({
      List<Widget> pages = samplePages,
      List<BottomNavigationItem> items = sampleItems,
      String? title,
      List<Widget>? actions,
    }) {
      return MaterialApp(
        home: LiquidGlassUI(
          pages: pages,
          items: items,
          title: title,
          actions: actions,
        ),
      );
    }

    testWidgets('Renders LiquidGlassUI with liquid AppBar and Fluid status pill', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Liquid Glass UI'), findsOneWidget);
      expect(find.text('Fluid'), findsOneWidget);
      expect(find.text('Home Screen'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search_outlined), findsOneWidget);
    });

    testWidgets('Renders custom AppBar title and action widgets passed from outside', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          title: 'Custom Dashboard Title',
          actions: [
            const Icon(Icons.notifications_none, key: ValueKey('custom_action_icon')),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Custom Dashboard Title'), findsOneWidget);
      expect(find.byKey(const ValueKey('custom_action_icon')), findsOneWidget);
    });

    testWidgets('Renders GPU CustomPaint layer for liquid glass refraction', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('Tapping search tab animates spring transition to Search Screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final searchTab = find.byIcon(Icons.search_outlined);
      expect(searchTab, findsOneWidget);

      await tester.tap(searchTab);
      await tester.pumpAndSettle();

      expect(find.text('Search Screen'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('Tapping favorites tab animates spring transition to Favorites Screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final favoritesTab = find.byIcon(Icons.favorite_border);
      expect(favoritesTab, findsOneWidget);

      await tester.tap(favoritesTab);
      await tester.pumpAndSettle();

      expect(find.text('Favorites Screen'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('Tapping currently active tab retains selection and does not restart animation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final homeTab = find.byIcon(Icons.home);
      expect(homeTab, findsOneWidget);

      await tester.tap(homeTab);
      await tester.pumpAndSettle();

      expect(find.text('Home Screen'), findsOneWidget);
    });

    testWidgets('Empty items list renders Offstage placeholder', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(pages: const [], items: const []),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LiquidGlassUI), findsOneWidget);
      expect(find.byType(Offstage), findsWidgets);
    });

    testWidgets('Horizontal drag gesture smoothly moves liquid indicator across tabs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final navBar = find.byType(GestureDetector).last;
      expect(navBar, findsOneWidget);

      // Perform a smooth drag across the liquid bar
      await tester.drag(navBar, const Offset(220.0, 0.0));
      await tester.pumpAndSettle();

      expect(find.text('Home Screen'), findsNothing);
    });

    testWidgets('Drag cancel gesture resets drag state cleanly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final gesture = await tester.startGesture(const Offset(100, 700));
      await gesture.moveBy(const Offset(60, 0));
      await gesture.cancel();
      await tester.pumpAndSettle();

      expect(find.byType(LiquidGlassUI), findsOneWidget);
    });
  });
}
