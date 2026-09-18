import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_morph_ui/glass_ui_kit.dart';

void main() {
  group('GlassUIKit Reusable Components & Extensions Tests', () {
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

    testWidgets('Applies .asLiquidGlass() widget extension method successfully',
        (
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

    testWidgets(
        'Renders standalone GlassAppBar with custom title, leftButtons and rightButtons',
        (
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
      expect(
          find.byKey(const ValueKey('liquid_settings_icon')), findsOneWidget);
    });

    testWidgets(
        'Renders standalone GlassBottomNavigationBar in bottomNavigationBar slot',
        (
      WidgetTester tester,
    ) async {
      int selectedIndex = 0;
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                appBar: const GlassAppBar(title: 'Standalone Navigation Demo'),
                body: Center(child: Text('Active Index: $selectedIndex')),
                bottomNavigationBar: GlassBottomNavigationBar(
                  selectedIndex: selectedIndex,
                  onTap: (index) => setState(() => selectedIndex = index),
                  items: const [
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
                  ],
                ),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Active Index: 0'), findsOneWidget);
      expect(find.byType(GlassBottomNavigationBar), findsOneWidget);

      await tester.tap(find.byIcon(Icons.search_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Active Index: 1'), findsOneWidget);
    });

    testWidgets(
        'Renders standalone LiquidGlassBottomNavBar in bottomNavigationBar slot',
        (
      WidgetTester tester,
    ) async {
      int selectedIndex = 0;
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                appBar: GlassAppBar.liquid(title: 'Liquid Nav Demo'),
                body: Center(child: Text('Liquid Index: $selectedIndex')),
                bottomNavigationBar: LiquidGlassBottomNavBar(
                  selectedIndex: selectedIndex,
                  onTap: (index) => setState(() => selectedIndex = index),
                  items: const [
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
                  ],
                ),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Liquid Index: 0'), findsOneWidget);
      expect(find.byType(LiquidGlassBottomNavBar), findsOneWidget);

      await tester.tap(find.byIcon(Icons.search_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Liquid Index: 1'), findsOneWidget);
    });

    testWidgets('Renders GlassButton and triggers onTap callback', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: GlassButton(
                label: 'Frosted Button',
                icon: Icons.check,
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Frosted Button'), findsOneWidget);
      await tester.tap(find.text('Frosted Button'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('Renders LiquidGlassButton and triggers onTap callback', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: LiquidGlassButton(
                label: 'Liquid Button',
                icon: Icons.water_drop,
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Liquid Button'), findsOneWidget);
      await tester.tap(find.text('Liquid Button'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('Renders GlassSwitch and updates state on toggle', (
      WidgetTester tester,
    ) async {
      bool switchVal = false;
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: GlassSwitch(
                    value: switchVal,
                    onChanged: (val) => setState(() => switchVal = val),
                  ),
                ),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GlassSwitch), findsOneWidget);
      await tester.tap(find.byType(GlassSwitch));
      await tester.pumpAndSettle();

      expect(switchVal, isTrue);
    });

    testWidgets('Renders LiquidGlassSwitch and updates state on toggle', (
      WidgetTester tester,
    ) async {
      bool switchVal = false;
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: LiquidGlassSwitch(
                    value: switchVal,
                    onChanged: (val) => setState(() => switchVal = val),
                  ),
                ),
              ),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LiquidGlassSwitch), findsOneWidget);
      await tester.tap(find.byType(LiquidGlassSwitch));
      await tester.pumpAndSettle();

      expect(switchVal, isTrue);
    });

    testWidgets('Renders GlassCard and LiquidGlassCard with child widgets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                GlassCard(child: Text('Card Content A')),
                LiquidGlassCard(child: Text('Card Content B')),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Card Content A'), findsOneWidget);
      expect(find.text('Card Content B'), findsOneWidget);
    });

    testWidgets(
        'Renders GlassTextField and LiquidGlassTextField accepting text input',
        (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                GlassTextField(hintText: 'Enter name'),
                LiquidGlassTextField(hintText: 'Enter password'),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Enter name'), findsOneWidget);
      expect(find.text('Enter password'), findsOneWidget);
    });

    testWidgets('Renders GlassmorphismProfileContent with avatar and options', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassmorphismProfileContent(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Vaibhav Joshi'), findsOneWidget);
      expect(find.text('Senior Flutter Developer'), findsOneWidget);
      expect(find.text('PRO MEMBER'), findsOneWidget);
      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.text('Logout Account'), findsOneWidget);
    });

    testWidgets(
        'Renders LiquidGlassProfileContent with cyan glowing avatar and options',
        (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LiquidGlassProfileContent(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Vaibhav Joshi'), findsOneWidget);
      expect(find.text('Senior Flutter Developer'), findsOneWidget);
      expect(find.text('FLUID PRO MEMBER'), findsOneWidget);
      expect(find.text('Push Notifications'), findsOneWidget);
      expect(find.text('Logout Account'), findsOneWidget);
    });

    testWidgets(
        'Renders GlassmorphismSearchContent with tags and category list', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassmorphismSearchContent(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GlassTextField), findsOneWidget);
      expect(find.text('TRENDING FROSTED CATEGORIES'), findsOneWidget);
      expect(find.byType(GlassCard), findsWidgets);
    });

    testWidgets(
        'Renders LiquidGlassSearchContent with tags and liquid category list', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LiquidGlassSearchContent(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LiquidGlassTextField), findsOneWidget);
      expect(find.text('TRENDING LIQUID CATEGORIES'), findsOneWidget);
      expect(find.byType(LiquidGlassCard), findsWidgets);
    });
  });
}
