import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:liquid_glass_ui/src/glass_ui_style.dart';

/// A customizable floating Glass AppBar supporting both Glassmorphism and Liquid Glass UI styles.
///
/// Allows developers to pass [title], [leftButtons], [rightButtons], [backgroundColor], and [blur] effortlessly.
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title text displayed in the AppBar.
  final String? title;

  /// Custom title Widget (takes precedence over [title]).
  final Widget? titleWidget;

  /// List of custom widgets/buttons on the left side.
  final List<Widget>? leftButtons;

  /// Single leading widget (takes precedence over [leftButtons]).
  final Widget? leading;

  /// List of custom widgets/buttons on the right side.
  final List<Widget>? rightButtons;

  /// Custom action widgets (alias for [rightButtons]).
  final List<Widget>? actions;

  /// Glass style variant ([GlassUIStyle.glassmorphism] or [GlassUIStyle.liquidGlass]).
  final GlassUIStyle style;

  /// Backdrop blur intensity.
  final double blur;

  /// Bar height (defaults to 56.0).
  final double height;

  /// Bar corner radius (defaults to 24.0).
  final double borderRadius;

  /// Translucent background fill color.
  final Color? backgroundColor;

  /// Translucent border color.
  final Color? borderColor;

  /// Whether to show the default back button when [Navigator.canPop] is true.
  final bool showBackButton;

  /// Creates a customizable [GlassAppBar].
  const GlassAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leftButtons,
    this.leading,
    this.rightButtons,
    this.actions,
    this.style = GlassUIStyle.glassmorphism,
    this.blur = 15.0,
    this.height = 56.0,
    this.borderRadius = 24.0,
    this.backgroundColor,
    this.borderColor,
    this.showBackButton = true,
  });

  /// Factory creating a Liquid Glass styled [GlassAppBar].
  factory GlassAppBar.liquid({
    Key? key,
    String? title,
    Widget? titleWidget,
    List<Widget>? leftButtons,
    Widget? leading,
    List<Widget>? rightButtons,
    List<Widget>? actions,
    double blur = 18.0,
    double height = 56.0,
    double borderRadius = 28.0,
    Color? backgroundColor,
    Color? borderColor,
    bool showBackButton = true,
  }) {
    return GlassAppBar(
      key: key,
      title: title,
      titleWidget: titleWidget,
      leftButtons: leftButtons,
      leading: leading,
      rightButtons: rightButtons,
      actions: actions,
      style: GlassUIStyle.liquidGlass,
      blur: blur,
      height: height,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      showBackButton: showBackButton,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height + 8.0);

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    final isLiquid = style == GlassUIStyle.liquidGlass;

    final effectiveBgColor = backgroundColor ??
        (isLiquid
            ? Colors.white.withValues(alpha: 0.10)
            : Colors.white.withValues(alpha: 0.12));

    final effectiveBorderColor = borderColor ??
        (isLiquid
            ? Colors.white.withValues(alpha: 0.30)
            : Colors.white.withValues(alpha: 0.25));

    final effectiveLeft = leftButtons ?? (leading != null ? [leading!] : null);

    // If liquid glass style and no right buttons passed, render the default 'Fluid' badge
    final effectiveRight = rightButtons ??
        actions ??
        (isLiquid
            ? [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white.withValues(alpha: 0.12),
                    border: Border.all(
                      color: const Color(0x8038BDF8),
                      width: 1.0,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.water_drop,
                        size: 12,
                        color: Color(0xFF38BDF8),
                      ),
                      Gap(4.0),
                      Text(
                        'Fluid',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            : null);

    final showBack =
        showBackButton && canPop && (effectiveLeft == null || effectiveLeft.isEmpty);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: effectiveBgColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: effectiveBorderColor,
                  width: 1.2,
                ),
                boxShadow: isLiquid
                    ? const [
                        BoxShadow(
                          color: Color(0x3038BDF8),
                          blurRadius: 12,
                          spreadRadius: -2,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  // 1. Left Buttons / Leading
                  if (showBack)
                    IconButton(
                      key: const ValueKey('liquid_app_bar_back_button'),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: isLiquid ? 16 : 18,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  if (effectiveLeft != null) ...effectiveLeft,

                  const Gap(8.0),

                  // 2. Title / Title Widget
                  Expanded(
                    child: titleWidget ??
                        Text(
                          title ?? (isLiquid ? 'Liquid Glass UI' : 'Glassmorphism UI'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),

                  // 3. Right Buttons / Actions
                  if (effectiveRight != null) ...effectiveRight,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
