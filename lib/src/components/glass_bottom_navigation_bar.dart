import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid_morph_ui/src/core/glass_navigation_controller.dart';
import 'package:liquid_morph_ui/src/core/glass_ui_contracts.dart';
import 'package:liquid_morph_ui/src/models/bottom_navigation_item.dart';

/// Standalone Glassmorphism Bottom Navigation Bar widget.
///
/// Easily placed inside any [Scaffold.bottomNavigationBar] independently of the AppBar.
class GlassBottomNavigationBar extends StatefulWidget {
  /// Currently selected tab index.
  final int selectedIndex;

  /// Callback triggered when a tab is tapped.
  final ValueChanged<int> onTap;

  /// Navigation items list.
  final List<BottomNavigationItem> items;

  /// Bar height (defaults to 70.0).
  final double height;

  /// Backdrop blur intensity.
  final double blur;

  /// Bar corner radius.
  final double borderRadius;

  /// Creates a standalone [GlassBottomNavigationBar].
  const GlassBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.items,
    this.height = 70.0,
    this.blur = 15.0,
    this.borderRadius = 50.0,
  });

  @override
  State<GlassBottomNavigationBar> createState() =>
      _GlassBottomNavigationBarState();
}

class _GlassBottomNavigationBarState extends State<GlassBottomNavigationBar> {
  late GlassNavigationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GlassNavigationController(itemCount: widget.items.length);
    if (widget.selectedIndex != 0) {
      _controller.selectTab(widget.selectedIndex, 100.0);
    }
  }

  @override
  void didUpdateWidget(covariant GlassBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.selectTab(widget.selectedIndex, 100.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pillRadius = BorderRadius.circular(widget.borderRadius);

    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
      child: ClipRRect(
        borderRadius: pillRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blur,
            sigmaY: widget.blur,
          ),
          child: Container(
            height: widget.height,
            decoration: GlassThemeFactory.createShellDecoration(
              color: const Color(0x1FFFFFFF),
              borderColor: const Color(0x40FFFFFF),
              borderRadius: widget.borderRadius,
              borderWidth: 1.2,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final count = widget.items.length;
                if (count == 0) return const Offstage();
                final itemWidth = constraints.maxWidth / count;

                return ValueListenableBuilder<GlassNavigationState>(
                  valueListenable: _controller,
                  builder: (context, state, _) {
                    return GestureDetector(
                      key: const ValueKey('glass_bottom_nav_bar_gesture'),
                      behavior: HitTestBehavior.opaque,
                      onHorizontalDragStart: (d) => DragUpdateCommand(
                        dragX: d.localPosition.dx,
                        barWidth: constraints.maxWidth,
                      ).execute(_controller),
                      onHorizontalDragUpdate: (d) => DragUpdateCommand(
                        dragX: d.localPosition.dx,
                        barWidth: constraints.maxWidth,
                      ).execute(_controller),
                      onHorizontalDragEnd: (d) {
                        DragEndCommand(
                          barWidth: constraints.maxWidth,
                          itemWidth: itemWidth,
                        ).execute(_controller);
                        widget.onTap(_controller.value.selectedIndex);
                      },
                      onHorizontalDragCancel: () => _controller.cancelDrag(),
                      child: Stack(
                        children: [
                          _buildSelectionCapsule(
                            state,
                            itemWidth,
                            constraints.maxWidth,
                          ),
                          Row(
                            children: widget.items.map((item) {
                              return Expanded(
                                child: InkWell(
                                  key: ValueKey('glass_tab_item_${item.index}'),
                                  borderRadius: pillRadius,
                                  onTap: () {
                                    SelectTabCommand(
                                      index: item.index,
                                      itemWidth: itemWidth,
                                    ).execute(_controller);
                                    widget.onTap(item.index);
                                  },
                                  child: Center(
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: Icon(
                                        widget.selectedIndex == item.index
                                            ? item.selectedIcon
                                            : item.unselectedIcon,
                                        key: ValueKey<bool>(
                                          widget.selectedIndex == item.index,
                                        ),
                                        color:
                                            widget.selectedIndex == item.index
                                                ? Colors.white
                                                : const Color(0x66FFFFFF),
                                        size: 25.0,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionCapsule(
    GlassNavigationState state,
    double itemWidth,
    double maxWidth,
  ) {
    final targetX = (widget.selectedIndex * itemWidth) + (itemWidth / 2);
    final currentX = state.dragX ?? targetX;
    final width = itemWidth * 0.72;
    final left = (currentX - (width / 2)).clamp(0.0, maxWidth - width);

    return AnimatedPositioned(
      duration:
          state.isDragging ? Duration.zero : const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: left,
      top: 8,
      bottom: 8,
      width: width,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }
}

/// Standalone Liquid Glass Bottom Navigation Bar widget.
///
/// Easily placed inside any [Scaffold.bottomNavigationBar] independently of the AppBar.
class LiquidGlassBottomNavBar extends StatefulWidget {
  /// Currently selected tab index.
  final int selectedIndex;

  /// Callback triggered when a tab is tapped.
  final ValueChanged<int> onTap;

  /// Navigation items list.
  final List<BottomNavigationItem> items;

  /// Bar height (defaults to 72.0).
  final double height;

  /// Backdrop blur intensity.
  final double blur;

  /// Bar corner radius.
  final double borderRadius;

  /// Creates a standalone [LiquidGlassBottomNavBar].
  const LiquidGlassBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.items,
    this.height = 72.0,
    this.blur = 18.0,
    this.borderRadius = 50.0,
  });

  @override
  State<LiquidGlassBottomNavBar> createState() =>
      _LiquidGlassBottomNavBarState();
}

class _LiquidGlassBottomNavBarState extends State<LiquidGlassBottomNavBar>
    with SingleTickerProviderStateMixin {
  late GlassNavigationController _controller;
  late AnimationController _animController;
  late Animation<double> _fluidAnimation;

  @override
  void initState() {
    super.initState();
    _controller = GlassNavigationController(itemCount: widget.items.length);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    _fluidAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Cubic(0.25, 1.15, 0.3, 1.0),
    );

    if (widget.selectedIndex != 0) {
      _controller.selectTab(widget.selectedIndex, 100.0);
    }
  }

  @override
  void didUpdateWidget(covariant LiquidGlassBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.selectTab(widget.selectedIndex, 100.0);
      _animController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pillRadius = BorderRadius.circular(widget.borderRadius);

    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: RepaintBoundary(
        child: ClipRRect(
          borderRadius: pillRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blur,
              sigmaY: widget.blur,
            ),
            child: Container(
              height: widget.height,
              decoration: GlassThemeFactory.createShellDecoration(
                color: Colors.transparent,
                borderColor: Colors.white.withValues(alpha: 0.20),
                borderRadius: widget.borderRadius,
                borderWidth: 1.2,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final count = widget.items.length;
                  if (count == 0) return const Offstage();
                  final itemWidth = constraints.maxWidth / count;

                  return ValueListenableBuilder<GlassNavigationState>(
                    valueListenable: _controller,
                    builder: (context, state, _) {
                      return GestureDetector(
                        key: const ValueKey('liquid_bottom_nav_bar_gesture'),
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragStart: (d) => DragUpdateCommand(
                          dragX: d.localPosition.dx,
                          barWidth: constraints.maxWidth,
                        ).execute(_controller),
                        onHorizontalDragUpdate: (d) => DragUpdateCommand(
                          dragX: d.localPosition.dx,
                          barWidth: constraints.maxWidth,
                        ).execute(_controller),
                        onHorizontalDragEnd: (d) {
                          DragEndCommand(
                            barWidth: constraints.maxWidth,
                            itemWidth: itemWidth,
                          ).execute(_controller);
                          _animController.forward(from: 0.0);
                          widget.onTap(_controller.value.selectedIndex);
                        },
                        onHorizontalDragCancel: () => _controller.cancelDrag(),
                        child: Stack(
                          children: [
                            AnimatedBuilder(
                              animation: _animController,
                              builder: (context, _) {
                                final progress = _animController.isAnimating
                                    ? _fluidAnimation.value
                                    : 1.0;
                                final currentX = state.dragX ??
                                    lerpDouble(
                                      state.startCenterX == 0
                                          ? (widget.selectedIndex * itemWidth +
                                              itemWidth / 2)
                                          : state.startCenterX,
                                      state.targetCenterX == 0
                                          ? (widget.selectedIndex * itemWidth +
                                              itemWidth / 2)
                                          : state.targetCenterX,
                                      progress,
                                    ) ??
                                    (widget.selectedIndex * itemWidth +
                                        itemWidth / 2);

                                final lightX = (currentX / constraints.maxWidth)
                                    .clamp(0.0, 1.0);

                                return CustomPaint(
                                  size:
                                      Size(constraints.maxWidth, widget.height),
                                  painter: _LiquidGlassPainter(
                                    currentCenterX: currentX,
                                    itemWidth: itemWidth,
                                    lightX: lightX,
                                    isDragging: state.isDragging,
                                    isAnimating: _animController.isAnimating,
                                    animValue: _fluidAnimation.value,
                                  ),
                                );
                              },
                            ),
                            Row(
                              children: widget.items.asMap().entries.map((e) {
                                final index = e.key;
                                final item = e.value;
                                final isSelected =
                                    widget.selectedIndex == index;

                                return Expanded(
                                  child: InkWell(
                                    key: ValueKey(
                                        'liquid_tab_item_${item.index}'),
                                    borderRadius: pillRadius,
                                    onTap: () {
                                      SelectTabCommand(
                                        index: index,
                                        itemWidth: itemWidth,
                                      ).execute(_controller);
                                      _animController.forward(from: 0.0);
                                      widget.onTap(index);
                                    },
                                    child: Center(
                                      child: AnimatedScale(
                                        scale: isSelected ? 1.15 : 1.0,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeOutCubic,
                                        child: Icon(
                                          isSelected
                                              ? item.selectedIcon
                                              : item.unselectedIcon,
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(0x70FFFFFF),
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom GPU Canvas Painter for Liquid Glass Light Refraction & Liquid Droplet Pill
class _LiquidGlassPainter extends CustomPainter {
  final double currentCenterX;
  final double itemWidth;
  final double lightX;
  final bool isDragging;
  final bool isAnimating;
  final double animValue;

  const _LiquidGlassPainter({
    required this.currentCenterX,
    required this.itemWidth,
    required this.lightX,
    required this.isDragging,
    required this.isAnimating,
    required this.animValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final barRRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(50.0),
    );

    // 1. Dynamic light sheen highlight along top border
    final sheenPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.05),
          Colors.white.withValues(alpha: isDragging ? 0.60 : 0.35),
          Colors.white.withValues(alpha: 0.05),
        ],
        stops: [
          (lightX - 0.35).clamp(0.0, 1.0),
          lightX,
          (lightX + 0.35).clamp(0.0, 1.0),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(barRRect, sheenPaint);

    // 2. Dynamic light refraction lens spot
    final lightSpotPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment((lightX * 2) - 1.0, -0.5),
        radius: isDragging ? 0.6 : 0.4,
        colors: [
          Colors.white.withValues(alpha: isDragging ? 0.18 : 0.08),
          Colors.transparent,
        ],
      ).createShader(rect);
    canvas.drawRRect(barRRect, lightSpotPaint);

    // 3. Liquid Selection Pill Capsule with Viscous Deformation
    final stretchFactor = isAnimating
        ? (0.20 * math.sin(animValue * math.pi))
        : (isDragging ? 0.10 : 0.0);
    final indicatorWidth = (itemWidth * 0.72) * (1.0 + stretchFactor);
    final indicatorHeight = (size.height - 16.0) * (1.0 - stretchFactor * 0.30);

    final left = (currentCenterX - (indicatorWidth / 2)).clamp(
      0.0,
      size.width - indicatorWidth,
    );
    final top = (size.height - indicatorHeight) / 2;

    final pillRect = Rect.fromLTWH(left, top, indicatorWidth, indicatorHeight);
    final pillRRect = RRect.fromRectAndRadius(
      pillRect,
      const Radius.circular(50.0),
    );

    // Outer cyan liquid glow shadow
    canvas.drawRRect(
      pillRRect,
      Paint()
        ..color = const Color(0x4038BDF8)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );

    // Liquid fill linear gradient
    canvas.drawRRect(
      pillRRect,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.35),
            Colors.white.withValues(alpha: 0.15),
          ],
          begin: Alignment(-1.0 + (lightX * 2), -1.0),
          end: Alignment(1.0 - (lightX * 2), 1.0),
        ).createShader(pillRect),
    );

    // Inner radial specular highlight
    canvas.drawRRect(
      pillRRect,
      Paint()
        ..shader = RadialGradient(
          center: Alignment(-0.5 + lightX, -0.6),
          radius: 0.8,
          colors: [Colors.white.withValues(alpha: 0.45), Colors.transparent],
        ).createShader(pillRect),
    );

    // Translucent border highlight
    canvas.drawRRect(
      pillRRect,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.50),
            Colors.white.withValues(alpha: 0.20),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(pillRect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(covariant _LiquidGlassPainter oldDelegate) {
    return oldDelegate.currentCenterX != currentCenterX ||
        oldDelegate.lightX != lightX ||
        oldDelegate.isDragging != isDragging ||
        oldDelegate.isAnimating != isAnimating ||
        oldDelegate.animValue != animValue;
  }
}
