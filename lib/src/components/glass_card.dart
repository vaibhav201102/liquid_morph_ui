import 'dart:ui';

import 'package:flutter/material.dart';

/// Reusable Glassmorphism Card component.
class GlassCard extends StatelessWidget {
  /// Card content widget.
  final Widget child;

  /// Backdrop blur intensity.
  final double blur;

  /// Card border radius.
  final double borderRadius;

  /// Translucent background color.
  final Color? color;

  /// Translucent border color.
  final Color? borderColor;

  /// Padding inside the card.
  final EdgeInsetsGeometry padding;

  /// Margin around the card.
  final EdgeInsetsGeometry? margin;

  /// Creates a [GlassCard].
  const GlassCard({
    super.key,
    required this.child,
    this.blur = 15.0,
    this.borderRadius = 20.0,
    this.color,
    this.borderColor,
    this.padding = const EdgeInsets.all(20.0),
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = BorderRadius.circular(borderRadius);

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ?? Colors.white.withValues(alpha: 0.12),
              borderRadius: effectiveRadius,
              border: Border.all(
                color: borderColor ?? Colors.white.withValues(alpha: 0.25),
                width: 1.2,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Reusable Liquid Glass Card component with cyan glow shadow.
class LiquidGlassCard extends StatelessWidget {
  /// Card content widget.
  final Widget child;

  /// Backdrop blur intensity.
  final double blur;

  /// Card border radius.
  final double borderRadius;

  /// Cyan liquid glow shadow color.
  final Color glowColor;

  /// Translucent background fill color (defaults to transparent for 100% glass clarity).
  final Color? color;

  /// Padding inside the card.
  final EdgeInsetsGeometry padding;

  /// Margin around the card.
  final EdgeInsetsGeometry? margin;

  /// Creates a [LiquidGlassCard].
  const LiquidGlassCard({
    super.key,
    required this.child,
    this.blur = 18.0,
    this.borderRadius = 24.0,
    this.glowColor = const Color(0x3038BDF8),
    this.color,
    this.padding = const EdgeInsets.all(20.0),
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = BorderRadius.circular(borderRadius);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: effectiveRadius,
        boxShadow: [
          BoxShadow(
            color: glowColor,
            blurRadius: 14,
            spreadRadius: -2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ?? Colors.transparent,
              borderRadius: effectiveRadius,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.30),
                width: 1.2,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
