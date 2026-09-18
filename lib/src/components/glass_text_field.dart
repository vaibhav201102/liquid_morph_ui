import 'dart:ui';

import 'package:flutter/material.dart';

/// Reusable Glassmorphism input TextField component.
class GlassTextField extends StatelessWidget {
  /// Controller for text input.
  final TextEditingController? controller;

  /// Hint text string.
  final String? hintText;

  /// Prefix icon.
  final IconData? prefixIcon;

  /// Suffix icon or widget.
  final Widget? suffixIcon;

  /// Whether text is obscure (for password fields).
  final bool obscureText;

  /// Value changed callback.
  final ValueChanged<String>? onChanged;

  /// Creates a [GlassTextField].
  const GlassTextField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16.0);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: radius,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1.2,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            onChanged: onChanged,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: Colors.white70, size: 20)
                  : null,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable Liquid Glass input TextField component with focus glow shadow.
class LiquidGlassTextField extends StatefulWidget {
  /// Controller for text input.
  final TextEditingController? controller;

  /// Hint text string.
  final String? hintText;

  /// Prefix icon.
  final IconData? prefixIcon;

  /// Suffix icon or widget.
  final Widget? suffixIcon;

  /// Whether text is obscure (for password fields).
  final bool obscureText;

  /// Focus glow shadow color.
  final Color focusGlowColor;

  /// Value changed callback.
  final ValueChanged<String>? onChanged;

  /// Creates a [LiquidGlassTextField].
  const LiquidGlassTextField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.focusGlowColor = const Color(0xFF38BDF8),
    this.onChanged,
  });

  @override
  State<LiquidGlassTextField> createState() => _LiquidGlassTextFieldState();
}

class _LiquidGlassTextFieldState extends State<LiquidGlassTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20.0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: _isFocused
                ? widget.focusGlowColor.withValues(alpha: 0.45)
                : const Color(0x2038BDF8),
            blurRadius: _isFocused ? 14 : 8,
            spreadRadius: _isFocused ? 0 : -2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: radius,
              border: Border.all(
                color: _isFocused
                    ? widget.focusGlowColor
                    : Colors.white.withValues(alpha: 0.30),
                width: _isFocused ? 1.5 : 1.2,
              ),
            ),
            child: TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              obscureText: widget.obscureText,
              onChanged: widget.onChanged,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle:
                    TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color:
                            _isFocused ? widget.focusGlowColor : Colors.white70,
                        size: 20,
                      )
                    : null,
                suffixIcon: widget.suffixIcon,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
