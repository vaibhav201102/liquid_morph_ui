import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_morph_ui/glass_ui_contracts.dart';
import 'package:liquid_morph_ui/src/glass_app_bar.dart';

/// Liquid Glass UI Screen implementing [GlassUIContract].
///
/// Fully customizable from the outside:
/// - Pass custom [appBar] or [title]
/// - Pass custom [leading] or [actions]
class LiquidGlassUI extends StatefulWidget implements GlassUIContract {
  @override
  final List<Widget> pages;

  @override
  final List<BottomNavigationItem> items;

  /// Custom preferred size AppBar passed from outside (optional).
  final PreferredSizeWidget? appBar;

  /// Custom title text displayed in default Glass AppBar (optional).
  final String? title;

  /// Custom title widget displayed in default Glass AppBar (optional).
  final Widget? titleWidget;

  /// Custom leading widget displayed in default Glass AppBar (optional).
  final Widget? leading;

  /// Custom action widgets displayed in default Glass AppBar (optional).
  final List<Widget>? actions;

  /// Whether to display the default back button in Glass AppBar.
  final bool showBackButton;

  /// Creates a [LiquidGlassUI] widget.
  const LiquidGlassUI({
    super.key,
    required this.pages,
    required this.items,
    this.appBar,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.showBackButton = true,
  });

  @override
  State<LiquidGlassUI> createState() => _LiquidGlassUIState();
}

class _LiquidGlassUIState extends State<LiquidGlassUI>
    with SingleTickerProviderStateMixin {
  late GlassNavigationController _controller;
  late PageController _pageController;
  late AnimationController _animController;
  late Animation<double> _fluidAnimation;

  static const double _blurSigma = 18.0;
  static const BorderRadius _pillRadius = BorderRadius.all(
    Radius.circular(50.0),
  );

  static const BoxDecoration _bgDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF0F172A), Color(0xFF1E1B4B), Color(0xFF311042)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = GlassNavigationController(itemCount: widget.items.length);
    _pageController = PageController(
      initialPage: _controller.value.selectedIndex,
    );
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    _fluidAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Cubic(0.25, 1.15, 0.3, 1.0),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassScope(
      controller: _controller,
      child: ValueListenableBuilder<GlassNavigationState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          return Scaffold(
            extendBody: true,
            appBar: _buildAppBar(context),
            body: Stack(
              children: [
                const Positioned.fill(
                  child: DecoratedBox(decoration: _bgDecoration),
                ),
                PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: widget.pages,
                ),
              ],
            ),
            bottomNavigationBar: _buildBottomNavBar(context, state),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    if (widget.appBar != null) return widget.appBar!;
    return GlassAppBar.liquid(
      title: widget.title,
      titleWidget: widget.titleWidget,
      leading: widget.leading,
      actions: widget.actions,
      showBackButton: widget.showBackButton,
    );
  }

  Widget _buildBottomNavBar(
    BuildContext context,
    GlassNavigationState state,
  ) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: RepaintBoundary(
        child: ClipRRect(
          borderRadius: _pillRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
            child: Container(
              height: 72.0,
              decoration: GlassThemeFactory.createShellDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderColor: Colors.white.withValues(alpha: 0.20),
                borderRadius: 50.0,
                borderWidth: 1.2,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final count = widget.items.length;
                  if (count == 0) return const Offstage();
                  final itemWidth = constraints.maxWidth / count;

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
                      if (_pageController.hasClients) {
                        _pageController.animateToPage(
                          _controller.value.selectedIndex,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutCubic,
                        );
                      }
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
                                      ? (state.selectedIndex * itemWidth +
                                          itemWidth / 2)
                                      : state.startCenterX,
                                  state.targetCenterX == 0
                                      ? (state.selectedIndex * itemWidth +
                                          itemWidth / 2)
                                      : state.targetCenterX,
                                  progress,
                                ) ??
                                (state.selectedIndex * itemWidth +
                                    itemWidth / 2);

                            final lightX = (currentX / constraints.maxWidth)
                                .clamp(0.0, 1.0);

                            return CustomPaint(
                              size: Size(constraints.maxWidth, 72.0),
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
                            return Expanded(
                              child: _buildNavItem(
                                context,
                                e.value,
                                e.key,
                                itemWidth,
                                state,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    BottomNavigationItem item,
    int index,
    double itemWidth,
    GlassNavigationState state,
  ) {
    final isSelected = state.selectedIndex == index;
    return InkWell(
      key: ValueKey('liquid_tab_item_${item.index}'),
      borderRadius: _pillRadius,
      onTap: () {
        SelectTabCommand(index: index, itemWidth: itemWidth)
            .execute(_controller);
        _animController.forward(from: 0.0);
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
          );
        }
      },
      child: Center(
        child: AnimatedScale(
          scale: isSelected ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Icon(
            isSelected ? item.selectedIcon : item.unselectedIcon,
            color: isSelected ? Colors.white : const Color(0x70FFFFFF),
            size: 24.0,
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
        ? math.sin(animValue * math.pi) * 0.20
        : (isDragging ? 0.10 : 0.0);
    final indicatorWidth =
        (itemWidth * 0.72) *
        (1.0 + stretchFactor); // Stretches horizontally when moving
    final indicatorHeight =
        (size.height - 16.0) *
        (1.0 - stretchFactor * 0.30); // Compresses vertically when moving

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

/// Model class representing configuration data for a bottom navigation item.
class BottomNavigationItem {
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final String label;
  final int index;

  const BottomNavigationItem({
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.index,
  });
}
