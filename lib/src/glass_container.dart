import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable glassmorphic container widget that applies backdrop blur,
/// translucent fill, and a subtle specular border around any child widget.
class GlassContainer extends StatelessWidget {
  /// Child widget wrapped inside the glass surface.
  final Widget child;

  /// Backdrop blur intensity (sigmaX and sigmaY).
  final double blur;

  /// Corner radius for the glass container.
  final BorderRadius? borderRadius;

  /// Translucent background fill color.
  final Color? color;

  /// Border color for the glass edge.
  final Color? borderColor;

  /// Thickness of the glass border.
  final double borderWidth;

  /// Padding inside the glass container.
  final EdgeInsetsGeometry? padding;

  /// Margin around the glass container.
  final EdgeInsetsGeometry? margin;

  /// Width of the container.
  final double? width;

  /// Height of the container.
  final double? height;

  /// Creates a reusable [GlassContainer].
  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 15.0,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.borderWidth = 1.2,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(20.0);
    final effectiveColor = color ?? Colors.white.withValues(alpha: 0.12);
    final effectiveBorderColor =
        borderColor ?? Colors.white.withValues(alpha: 0.25);

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: effectiveColor,
              borderRadius: effectiveRadius,
              border: Border.all(
                color: effectiveBorderColor,
                width: borderWidth,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A reusable Liquid Glass container widget featuring dynamic light refraction,
/// cyan glow, and translucent glass shell.
class LiquidGlassContainer extends StatelessWidget {
  /// Child widget wrapped inside the liquid glass surface.
  final Widget child;

  /// Backdrop blur intensity.
  final double blur;

  /// Corner radius for the container.
  final BorderRadius? borderRadius;

  /// Translucent background fill color.
  final Color? color;

  /// Cyan liquid glow shadow color.
  final Color glowColor;

  /// Padding inside the container.
  final EdgeInsetsGeometry? padding;

  /// Margin around the container.
  final EdgeInsetsGeometry? margin;

  /// Width of the container.
  final double? width;

  /// Height of the container.
  final double? height;

  /// Creates a reusable [LiquidGlassContainer].
  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.blur = 18.0,
    this.borderRadius,
    this.color,
    this.glowColor = const Color(0x3038BDF8),
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(24.0);
    final effectiveColor = color ?? Colors.white.withValues(alpha: 0.10);

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: effectiveColor,
              borderRadius: effectiveRadius,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.30),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: glowColor,
                  blurRadius: 12,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
