import 'dart:ui';
import 'package:flutter/material.dart';

/// Reusable Glassmorphism animated Switch toggle component.
class GlassSwitch extends StatelessWidget {
  /// Current switch state (true = ON, false = OFF).
  final bool value;

  /// Callback when state changes.
  final ValueChanged<bool> onChanged;

  /// Width of switch track (defaults to 60.0).
  final double width;

  /// Height of switch track (defaults to 32.0).
  final double height;

  /// Backdrop blur intensity.
  final double blur;

  /// Creates a [GlassSwitch].
  const GlassSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 60.0,
    this.height = 32.0,
    this.blur = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    final trackRadius = BorderRadius.circular(height / 2);
    final thumbSize = height - 10.0;

    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: ClipRRect(
        borderRadius: trackRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: width,
            height: height,
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              color: value
                  ? Colors.white.withValues(alpha: 0.25)
                  : Colors.white.withValues(alpha: 0.08),
              borderRadius: trackRadius,
              border: Border.all(
                color: value
                    ? Colors.white.withValues(alpha: 0.50)
                    : Colors.white.withValues(alpha: 0.20),
                width: 1.2,
              ),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: thumbSize,
                height: thumbSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 4,
                      spreadRadius: 0.5,
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

/// Reusable Liquid Glass animated Switch component with cyan glow thumb slider.
class LiquidGlassSwitch extends StatelessWidget {
  /// Current switch state (true = ON, false = OFF).
  final bool value;

  /// Callback when state changes.
  final ValueChanged<bool> onChanged;

  /// Width of switch track (defaults to 64.0).
  final double width;

  /// Height of switch track (defaults to 34.0).
  final double height;

  /// Cyan liquid glow shadow color when ON.
  final Color activeGlowColor;

  /// Creates a [LiquidGlassSwitch].
  const LiquidGlassSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 64.0,
    this.height = 34.0,
    this.activeGlowColor = const Color(0xFF38BDF8),
  });

  @override
  Widget build(BuildContext context) {
    final trackRadius = BorderRadius.circular(height / 2);
    final thumbSize = height - 10.0;

    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: trackRadius,
          boxShadow: [
            BoxShadow(
              color: value
                  ? activeGlowColor.withValues(alpha: 0.5)
                  : Colors.transparent,
              blurRadius: 10,
              spreadRadius: -1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: trackRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: width,
              height: height,
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: value
                    ? activeGlowColor.withValues(alpha: 0.20)
                    : Colors.white.withValues(alpha: 0.08),
                borderRadius: trackRadius,
                border: Border.all(
                  color: value
                      ? activeGlowColor.withValues(alpha: 0.60)
                      : Colors.white.withValues(alpha: 0.20),
                  width: 1.2,
                ),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutBack,
                alignment:
                    value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: thumbSize,
                  height: thumbSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: value
                          ? [Colors.white, activeGlowColor]
                          : [
                              Colors.white.withValues(alpha: 0.9),
                              Colors.white60,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: value
                            ? activeGlowColor.withValues(alpha: 0.4)
                            : Colors.black26,
                        blurRadius: 6,
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
