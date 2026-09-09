import 'package:flutter/material.dart';
import 'package:glass_bottom_bar_ui/src/glass_container.dart';

/// Convenient extension methods to apply Glass UI effects directly onto any Widget.
extension GlassWidgetExtension on Widget {
  /// Wraps the current widget in a classic [GlassContainer] frosted glass surface.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello World').asGlass(
  ///   blur: 15.0,
  ///   borderRadius: BorderRadius.circular(16.0),
  /// )
  /// ```
  Widget asGlass({
    Key? key,
    double blur = 15.0,
    BorderRadius? borderRadius,
    Color? color,
    Color? borderColor,
    double borderWidth = 1.2,
    EdgeInsetsGeometry? padding = const EdgeInsets.all(16.0),
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
  }) {
    return GlassContainer(
      key: key,
      blur: blur,
      borderRadius: borderRadius,
      color: color,
      borderColor: borderColor,
      borderWidth: borderWidth,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: this,
    );
  }

  /// Wraps the current widget in a dynamic [LiquidGlassContainer] liquid glass surface.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello World').asLiquidGlass(
  ///   blur: 18.0,
  ///   glowColor: Color(0x3038BDF8),
  /// )
  /// ```
  Widget asLiquidGlass({
    Key? key,
    double blur = 18.0,
    BorderRadius? borderRadius,
    Color? color,
    Color glowColor = const Color(0x3038BDF8),
    EdgeInsetsGeometry? padding = const EdgeInsets.all(16.0),
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
  }) {
    return LiquidGlassContainer(
      key: key,
      blur: blur,
      borderRadius: borderRadius,
      color: color,
      glowColor: glowColor,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: this,
    );
  }
}
