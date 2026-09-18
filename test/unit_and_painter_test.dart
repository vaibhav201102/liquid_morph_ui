import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_morph_ui/glass_ui_kit.dart';

void main() {
  group('GlassNavigationController Unit Tests', () {
    test('Initializes controller with correct default state', () {
      final controller = GlassNavigationController(itemCount: 4);

      expect(controller.value.selectedIndex, 0);
      expect(controller.value.dragX, isNull);
      expect(controller.value.isDragging, isFalse);
      expect(controller.value.startCenterX, 0.0);
      expect(controller.value.targetCenterX, 0.0);

      controller.dispose();
    });

    test('selectTab command updates selected index and notifies listeners', () {
      final controller = GlassNavigationController(itemCount: 4);
      bool notified = false;
      controller.addListener(() => notified = true);

      SelectTabCommand(index: 2, itemWidth: 100.0).execute(controller);

      expect(controller.value.selectedIndex, 2);
      expect(controller.value.targetCenterX, 250.0);
      expect(controller.value.isDragging, isFalse);
      expect(notified, isTrue);

      controller.dispose();
    });

    test('DragUpdateCommand and DragEndCommand handle touch gesture pipeline', () {
      final controller = GlassNavigationController(itemCount: 4);

      // 1. Update drag position
      DragUpdateCommand(dragX: 180.0, barWidth: 400.0).execute(controller);
      expect(controller.value.isDragging, isTrue);
      expect(controller.value.dragX, 180.0);

      // 2. End drag snaps to closest item (itemWidth = 100.0 => index 1)
      DragEndCommand(barWidth: 400.0, itemWidth: 100.0).execute(controller);
      expect(controller.value.isDragging, isFalse);
      expect(controller.value.dragX, isNull);
      expect(controller.value.selectedIndex, 1);

      controller.dispose();
    });

    test('cancelDrag resets dragX and isDragging state', () {
      final controller = GlassNavigationController(itemCount: 4);
      DragUpdateCommand(dragX: 120.0, barWidth: 400.0).execute(controller);

      expect(controller.value.isDragging, isTrue);
      controller.cancelDrag();

      expect(controller.value.isDragging, isFalse);
      expect(controller.value.dragX, isNull);

      controller.dispose();
    });
  });

  group('GlassNavigationState Value Equality & CopyWith Tests', () {
    test('copyWith creates new state with modified properties', () {
      const initial = GlassNavigationState(selectedIndex: 0);
      final updated = initial.copyWith(selectedIndex: 2, isDragging: true);

      expect(updated.selectedIndex, 2);
      expect(updated.isDragging, isTrue);
      expect(initial.selectedIndex, 0);
    });

    test('operator == and hashCode verify value equality', () {
      const stateA = GlassNavigationState(selectedIndex: 1, isDragging: false);
      const stateB = GlassNavigationState(selectedIndex: 1, isDragging: false);
      const stateC = GlassNavigationState(selectedIndex: 2, isDragging: false);

      expect(stateA, equals(stateB));
      expect(stateA.hashCode, equals(stateB.hashCode));
      expect(stateA, isNot(equals(stateC)));
    });
  });

  group('GlassScope Unit & Widget Tests', () {
    testWidgets('GlassScope provides GlassNavigationController down widget tree', (
      WidgetTester tester,
    ) async {
      final controller = GlassNavigationController(itemCount: 3);

      await tester.pumpWidget(
        MaterialApp(
          home: GlassScope(
            controller: controller,
            child: Builder(
              builder: (context) {
                final scopedController = GlassScope.of(context);
                return Text('Active Index: ${scopedController.value.selectedIndex}');
              },
            ),
          ),
        ),
      );

      expect(find.text('Active Index: 0'), findsOneWidget);

      controller.dispose();
    });
  });

  group('BottomNavigationItem & GlassUIStyle Unit Tests', () {
    test('Creates BottomNavigationItem data object correctly', () {
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

    test('GlassUIStyle enum contains expected style variants', () {
      expect(GlassUIStyle.values.contains(GlassUIStyle.glassmorphism), isTrue);
      expect(GlassUIStyle.values.contains(GlassUIStyle.liquidGlass), isTrue);
    });
  });
}
