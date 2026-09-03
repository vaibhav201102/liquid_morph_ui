import 'package:flutter/foundation.dart';

/// IMMUTABLE VALUE OBJECT (State Encapsulation)
/// Represents the complete immutable state of a Glass Navigation Component.
@immutable
class GlassNavigationState {
  /// Index of currently selected navigation tab.
  final int selectedIndex;

  /// Index of previously selected tab.
  final int previousIndex;

  /// Current horizontal touch position in pixels (null when not dragging).
  final double? dragX;

  /// Whether user is actively dragging across the bar.
  final bool isDragging;

  /// Start X coordinate for current transition animation.
  final double startCenterX;

  /// Target X coordinate for current transition animation.
  final double targetCenterX;

  /// Creates an immutable [GlassNavigationState].
  const GlassNavigationState({
    this.selectedIndex = 0,
    this.previousIndex = 0,
    this.dragX,
    this.isDragging = false,
    this.startCenterX = 0.0,
    this.targetCenterX = 0.0,
  });

  /// Creates a copy of [GlassNavigationState] with updated fields.
  GlassNavigationState copyWith({
    int? selectedIndex,
    int? previousIndex,
    double? dragX,
    bool? isDragging,
    double? startCenterX,
    double? targetCenterX,
  }) {
    return GlassNavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      previousIndex: previousIndex ?? this.previousIndex,
      dragX: dragX,
      isDragging: isDragging ?? this.isDragging,
      startCenterX: startCenterX ?? this.startCenterX,
      targetCenterX: targetCenterX ?? this.targetCenterX,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GlassNavigationState &&
        other.selectedIndex == selectedIndex &&
        other.previousIndex == previousIndex &&
        other.dragX == dragX &&
        other.isDragging == isDragging &&
        other.startCenterX == startCenterX &&
        other.targetCenterX == targetCenterX;
  }

  @override
  int get hashCode => Object.hash(
        selectedIndex,
        previousIndex,
        dragX,
        isDragging,
        startCenterX,
        targetCenterX,
      );
}

/// COMMAND PATTERN
/// Abstract command interface for navigation interactions.
abstract class GlassNavigationCommand {
  /// Executes command against the target controller.
  void execute(GlassNavigationController controller);
}

/// Selects a tab by index.
class SelectTabCommand implements GlassNavigationCommand {
  final int index;
  final double itemWidth;

  const SelectTabCommand({required this.index, required this.itemWidth});

  @override
  void execute(GlassNavigationController controller) {
    controller.selectTab(index, itemWidth);
  }
}

/// Updates horizontal drag position.
class DragUpdateCommand implements GlassNavigationCommand {
  final double dragX;
  final double barWidth;

  const DragUpdateCommand({required this.dragX, required this.barWidth});

  @override
  void execute(GlassNavigationController controller) {
    controller.updateDrag(dragX, barWidth);
  }
}

/// Concludes horizontal drag.
class DragEndCommand implements GlassNavigationCommand {
  final double barWidth;
  final double itemWidth;

  const DragEndCommand({required this.barWidth, required this.itemWidth});

  @override
  void execute(GlassNavigationController controller) {
    controller.endDrag(barWidth, itemWidth);
  }
}

/// REACTIVE STATE CONTROLLER (Observer Pattern)
/// Manages tab state, drag gestures, and physics updates reactively.
class GlassNavigationController extends ValueNotifier<GlassNavigationState> {
  final int itemCount;

  /// Creates a [GlassNavigationController].
  GlassNavigationController({required this.itemCount})
      : super(const GlassNavigationState());

  /// Selects a new tab and triggers position interpolation.
  void selectTab(int index, double itemWidth) {
    if (index < 0 || index >= itemCount) return;
    final targetX = (index * itemWidth) + (itemWidth / 2);
    final currentX = getCurrentCenterX(itemWidth);

    value = value.copyWith(
      previousIndex: value.selectedIndex,
      selectedIndex: index,
      startCenterX: currentX,
      targetCenterX: targetX,
      isDragging: false,
    );
  }

  /// Updates current touch drag position.
  void updateDrag(double rawX, double barWidth) {
    final clampedX = rawX.clamp(0.0, barWidth);
    value = value.copyWith(
      dragX: clampedX,
      isDragging: true,
    );
  }

  /// Concludes drag gesture and snaps to nearest tab.
  void endDrag(double barWidth, double itemWidth) {
    if (value.dragX == null) return;
    final calculatedIndex = (value.dragX! / itemWidth).floor().clamp(0, itemCount - 1);
    final targetX = (calculatedIndex * itemWidth) + (itemWidth / 2);

    value = value.copyWith(
      previousIndex: value.selectedIndex,
      selectedIndex: calculatedIndex,
      startCenterX: value.dragX!,
      targetCenterX: targetX,
      isDragging: false,
    );
  }

  /// Cancels drag gesture without tab index change.
  void cancelDrag() {
    value = value.copyWith(isDragging: false);
  }

  /// Calculates current center X position based on active drag or target state.
  double getCurrentCenterX(double itemWidth) {
    if (value.dragX != null) return value.dragX!;
    if (value.targetCenterX > 0) return value.targetCenterX;
    return (value.selectedIndex * itemWidth) + (itemWidth / 2);
  }
}
