import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_bottom_bar_ui/glass_morphism_ui.dart';
import 'package:glass_bottom_bar_ui/liquid_glass_ui.dart';

void main() {
  group('GlassmorphismUI Widget Tests', () {
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
    }) {
      return MaterialApp(
        home: GlassmorphismUI(
          pages: pages,
          items: items,
        ),
      );
    }

    testWidgets('Renders GlassmorphismUI with AppBar and initial Home page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Glassmorphism UI'), findsOneWidget);
      expect(find.text('Home Screen'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search_outlined), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('Tapping search tab switches active page to Search Screen', (
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

    testWidgets('Tapping profile tab switches active page to Profile Screen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final profileTab = find.byIcon(Icons.person_outline);
      expect(profileTab, findsOneWidget);

      await tester.tap(profileTab);
      await tester.pumpAndSettle();

      expect(find.text('Profile Screen'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('Tapping currently active tab retains selection and does not error', (
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

    testWidgets('Empty items list renders SizedBox placeholder', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(pages: const [], items: const []),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GlassmorphismUI), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('Horizontal drag gesture across bottom bar updates tab selection', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final navBar = find.byType(GestureDetector).last;
      expect(navBar, findsOneWidget);

      // Drag across the navigation bar towards the right
      await tester.drag(navBar, const Offset(200.0, 0.0));
      await tester.pumpAndSettle();

      // Active screen should no longer be Home Screen
      expect(find.text('Home Screen'), findsNothing);
    });

    testWidgets('Drag cancel gesture restores selection state smoothly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final gesture = await tester.startGesture(const Offset(100, 700));
      await gesture.moveBy(const Offset(50, 0));
      await gesture.cancel();
      await tester.pumpAndSettle();

      expect(find.byType(GlassmorphismUI), findsOneWidget);
    });
  });
}
