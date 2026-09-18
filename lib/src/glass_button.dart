import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Reusable Glassmorphism Button component with frosted glass styling and press animation.
class GlassButton extends StatefulWidget {
  /// Button onPressed callback.
  final VoidCallback onTap;

  /// Optional leading icon.
  final IconData? icon;

  /// Button text label.
  final String label;

  /// Custom text style.
  final TextStyle? labelStyle;

  /// Backdrop blur intensity.
  final double blur;

  /// Button padding.
  final EdgeInsetsGeometry padding;

  /// Button border radius.
  final double borderRadius;

  /// Translucent background fill color.
  final Color? color;

  /// Translucent border color.
  final Color? borderColor;

  /// Creates a [GlassButton].
  const GlassButton({
    super.key,
    required this.onTap,
    required this.label,
    this.icon,
    this.labelStyle,
    this.blur = 15.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.borderRadius = 16.0,
    this.color,
    this.borderColor,
  });

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = BorderRadius.circular(widget.borderRadius);
    final effectiveBg = widget.color ?? Colors.white.withValues(alpha: 0.12);
    final effectiveBorder =
        widget.borderColor ?? Colors.white.withValues(alpha: 0.28);

    return AnimatedScale(
      scale: _isPressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              onTap: widget.onTap,
              borderRadius: effectiveRadius,
              child: Container(
                padding: widget.padding,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      effectiveBg,
                      effectiveBg.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: effectiveRadius,
                  border: Border.all(color: effectiveBorder, width: 1.2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: Colors.white, size: 18),
                      const Gap(6.0),
                    ],
                    Flexible(
                      child: Text(
                        widget.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: widget.labelStyle ??
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable Liquid Glass Button component with cyan glow shadow and dynamic glass reflection.
class LiquidGlassButton extends StatefulWidget {
  /// Button onPressed callback.
  final VoidCallback onTap;

  /// Optional leading icon.
  final IconData? icon;

  /// Button text label.
  final String label;

  /// Custom text style.
  final TextStyle? labelStyle;

  /// Backdrop blur intensity.
  final double blur;

  /// Button padding.
  final EdgeInsetsGeometry padding;

  /// Button border radius.
  final double borderRadius;

  /// Liquid cyan glow shadow color.
  final Color glowColor;

  /// Creates a [LiquidGlassButton].
  const LiquidGlassButton({
    super.key,
    required this.onTap,
    required this.label,
    this.icon,
    this.labelStyle,
    this.blur = 18.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.borderRadius = 18.0,
    this.glowColor = const Color(0x5038BDF8),
  });

  @override
  State<LiquidGlassButton> createState() => _LiquidGlassButtonState();
}

class _LiquidGlassButtonState extends State<LiquidGlassButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = BorderRadius.circular(widget.borderRadius);

    return AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          borderRadius: effectiveRadius,
          boxShadow: [
            BoxShadow(
              color: widget.glowColor,
              blurRadius: _isPressed ? 6 : 14,
              spreadRadius: _isPressed ? -3 : -1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: effectiveRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTapDown: (_) => setState(() => _isPressed = true),
                onTapUp: (_) => setState(() => _isPressed = false),
                onTapCancel: () => setState(() => _isPressed = false),
                onTap: widget.onTap,
                borderRadius: effectiveRadius,
                child: Container(
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.18),
                        Colors.white.withValues(alpha: 0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: effectiveRadius,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          color: const Color(0xFF38BDF8),
                          size: 18,
                        ),
                        const Gap(6.0),
                      ],
                      Flexible(
                        child: Text(
                          widget.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: widget.labelStyle ??
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
