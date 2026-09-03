import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glass_bottom_bar_ui/glass_ui_contracts.dart';

/// Liquid Glass UI Screen implementing [GlassUIContract].
///
/// OOP PATTERNS USED:
/// 1. Abstraction (conforms to [GlassUIContract])
/// 2. Encapsulation (gesture physics encapsulated in [TabGesturePhysics])
/// 3. Factory Pattern (uses [GlassThemeFactory])
/// 4. Strategy Pattern (Custom Canvas Painter [_LiquidGlassPainter])
class LiquidGlassUI extends StatefulWidget implements GlassUIContract {
  @override
  final List<Widget> pages;

  @override
  final List<BottomNavigationItem> items;

  /// Creates a [LiquidGlassUI] widget.
  const LiquidGlassUI({
    super.key,
    required this.pages,
    required this.items,
  });

  @override
  State<LiquidGlassUI> createState() => _LiquidGlassUIState();
}

class _LiquidGlassUIState extends State<LiquidGlassUI>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  double? _dragX;
  bool _isDragging = false;

  double _startCenterX = 0.0;
  double _targetCenterX = 0.0;

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
    _pageController = PageController(initialPage: _selectedIndex);
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
    super.dispose();
  }

  double _getCurrentCenterX(double itemWidth) {
    if (_dragX != null) return _dragX!;
    if (!_animController.isAnimating && _targetCenterX > 0) {
      return _targetCenterX;
    }
    return lerpDouble(_startCenterX, _targetCenterX, _fluidAnimation.value) ??
        (_selectedIndex * itemWidth + itemWidth / 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(),
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
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64.0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
              child: Container(
                height: 56.0,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(28.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.30),
                    width: 1.2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3038BDF8),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    InkWell(
                      key: const ValueKey('liquid_app_bar_back_button'),
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.35),
                            width: 1.0,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    const Gap(12.0),
                    const Text(
                      'Liquid Glass UI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
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
                  final physics = TabGesturePhysics(itemCount: count);

                  if (_targetCenterX == 0) {
                    _startCenterX = physics.calculateTargetX(
                      _selectedIndex,
                      itemWidth,
                    );
                    _targetCenterX = _startCenterX;
                  }

                  return GestureDetector(
                    key: const ValueKey('liquid_bottom_nav_bar_gesture'),
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragStart: (d) => setState(() {
                      _isDragging = true;
                      _dragX = d.localPosition.dx.clamp(
                        0.0,
                        constraints.maxWidth,
                      );
                    }),
                    onHorizontalDragUpdate: (d) => setState(
                      () => _dragX = d.localPosition.dx.clamp(
                        0.0,
                        constraints.maxWidth,
                      ),
                    ),
                    onHorizontalDragEnd: (d) =>
                        _onDragEnd(physics, constraints.maxWidth, itemWidth),
                    onHorizontalDragCancel: () => setState(() {
                      _isDragging = false;
                      _dragX = null;
                    }),
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _animController,
                          builder: (context, _) {
                            final currentX = _getCurrentCenterX(itemWidth);
                            final lightX = (currentX / constraints.maxWidth)
                                .clamp(0.0, 1.0);
                            return CustomPaint(
                              size: Size(constraints.maxWidth, 72.0),
                              painter: _LiquidGlassPainter(
                                currentCenterX: currentX,
                                itemWidth: itemWidth,
                                lightX: lightX,
                                isDragging: _isDragging,
                                isAnimating: _animController.isAnimating,
                                animValue: _fluidAnimation.value,
                              ),
                            );
                          },
                        ),
                        Row(
                          children: widget.items.asMap().entries.map((e) {
                            return Expanded(
                              child: _buildNavItem(e.value, e.key, itemWidth),
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
    BottomNavigationItem item,
    int index,
    double itemWidth,
  ) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      key: ValueKey('liquid_tab_item_${item.index}'),
      borderRadius: _pillRadius,
      onTap: () => _onTabTap(index, itemWidth),
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

  void _onTabTap(int index, double itemWidth) {
    final physics = TabGesturePhysics(itemCount: widget.items.length);
    final target = physics.calculateTargetX(index, itemWidth);
    if (_selectedIndex == index && _targetCenterX == target) return;

    final currentX = _getCurrentCenterX(itemWidth);
    setState(() {
      _startCenterX = currentX;
      _targetCenterX = target;
      _selectedIndex = index;
      _dragX = null;
      _isDragging = false;
    });

    _animController.forward(from: 0.0);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onDragEnd(
    TabGesturePhysics physics,
    double barWidth,
    double itemWidth,
  ) {
    if (_dragX == null) return;
    final newIndex = physics.calculateIndex(_dragX!, itemWidth);
    final target = physics.calculateTargetX(newIndex, itemWidth);

    setState(() {
      _startCenterX = _dragX!;
      _targetCenterX = target;
      _selectedIndex = newIndex;
      _dragX = null;
      _isDragging = false;
    });

    _animController.forward(from: 0.0);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        newIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
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
