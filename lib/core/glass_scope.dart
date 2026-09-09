import 'package:flutter/material.dart';
import 'package:liquid_glass_ui_kit/core/glass_navigation_controller.dart';

/// DEPENDENCY INJECTION & SCOPE PATTERN
/// Injects [GlassNavigationController] reactively down the BuildContext tree.
class GlassScope extends InheritedNotifier<GlassNavigationController> {
  /// Creates a [GlassScope] dependency wrapper.
  const GlassScope({
    super.key,
    required GlassNavigationController controller,
    required super.child,
  }) : super(notifier: controller);

  /// Obtains the nearest [GlassNavigationController] from the widget hierarchy.
  static GlassNavigationController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<GlassScope>();
    assert(scope != null, 'No GlassScope found in BuildContext hierarchy.');
    return scope!.notifier!;
  }
}
