import 'package:flutter/material.dart';
import 'package:liquid_morph_ui/liquid_glass_ui.dart';

/// ABSTRACTION & INTERFACE
/// Contract defining mandatory requirements for any Glass UI variant.
abstract class GlassUIContract {
  /// Pages to display for each tab.
  List<Widget> get pages;

  /// Navigation items for each tab.
  List<BottomNavigationItem> get items;
}

/// STRATEGY PATTERN & POLYMORPHISM
/// Abstract engine strategy interface for rendering selection indicators and executing physics.
abstract class GlassNavigationEngine {
  /// Renders indicator overlay.
  Widget buildIndicator({
    required BuildContext context,
    required double itemWidth,
    required double barWidth,
    required int selectedIndex,
    required double? dragPosition,
  });
}

/// FACTORY PATTERN
/// Factory producing standardized Glass UI shell decorations.
abstract class GlassThemeFactory {
  /// Creates a standardized frosted glass container decoration.
  static BoxDecoration createShellDecoration({
    required Color color,
    required Color borderColor,
    required double borderRadius,
    required double borderWidth,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor, width: borderWidth),
    );
  }
}
