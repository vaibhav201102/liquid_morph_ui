import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

/// A widget that displays a dynamic, behavior-driven Liquid Glass bottom navigation bar UI.
///
/// Built for 120 FPS ultra-smooth performance using isolated GPU canvas rendering and zero-rebuild backdrop filtering.
class LiquidGlassUI extends StatefulWidget {
  /// List of page widgets corresponding to each tab index.
  final List<Widget> pages;

  /// Configuration items for each bottom navigation tab.
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

/// State for [LiquidGlassUI] managing ultra-smooth GPU animations and touch gestures.
class _LiquidGlassUIState extends State<LiquidGlassUI>
    with SingleTickerProviderStateMixin {
  /// Index of the currently selected navigation tab.
  int _selectedIndex = 0;

  /// Raw X coordinate during active drag gestures.
  double? _dragX;

  /// Flag indicating if user is currently dragging across the navigation bar.
  bool _isDragging = false;

  /// Start X position of the liquid indicator for current transition.
  double _startCenterX = 0.0;

  /// Target X position of the liquid indicator for current transition.
  double _targetCenterX = 0.0;

  /// Page controller managing smooth page transitions.
  late PageController _pageController;

  /// Animation controller for fluid spring transitions.
  late AnimationController _animController;

  /// Curved animation supplying spring elasticity.
  late Animation<double> _fluidAnimation;

  // UI & Design Constants
  static const double _borderRadius = 50.0;
  static const double _iconSize = 24.0;
  static const double _navigationBarHeight = 72.0;
  static const double _horizontalPadding = 32.0;
  static const double _verticalPadding = 16.0;
  static const double _blurSigma = 18.0;
  static const double _borderWidth = 1.2;

  // AppBar Constants
  static const double _appBarHeight = 64.0;
  static const double _appBarInnerHeight = 56.0;
  static const double _appBarRadius = 28.0;
  static const Size _appBarPreferredSize = Size.fromHeight(_appBarHeight);
  static const EdgeInsets _appBarPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 4.0,
  );
  static const EdgeInsets _appBarInnerPadding = EdgeInsets.symmetric(
    horizontal: 12.0,
  );
  static const BorderRadius _appBarBorderRadius = BorderRadius.all(
    Radius.circular(_appBarRadius),
  );
  static const Color _appBarBackgroundColor = Color(0x1AFFFFFF);
  static const Color _appBarBorderColor = Color(0x4DFFFFFF);
  static const Color _appBarShadowColor = Color(0x3038BDF8);
  static const BoxShadow _appBarBoxShadow = BoxShadow(
    color: _appBarShadowColor,
    blurRadius: 12,
    spreadRadius: -2,
  );
  static const List<BoxShadow> _appBarBoxShadows = [_appBarBoxShadow];
  static const BorderSide _appBarBorderSide = BorderSide(
    color: _appBarBorderColor,
    width: _borderWidth,
  );
  static const Border _appBarBorder = Border.fromBorderSide(_appBarBorderSide);
  static const BoxDecoration _appBarDecoration = BoxDecoration(
    color: _appBarBackgroundColor,
    borderRadius: _appBarBorderRadius,
    border: _appBarBorder,
    boxShadow: _appBarBoxShadows,
  );
  static const TextStyle _appBarTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle _statusTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
  static const Color _statusBorderColor = Color(0x8038BDF8);
  static const Color _statusBackgroundColor = Color(0x1FFFFFFF);
  static const BoxDecoration _statusDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    color: _statusBackgroundColor,
    border: Border.fromBorderSide(
      BorderSide(color: _statusBorderColor, width: 1.0),
    ),
  );
  static const Icon _backIcon = Icon(
    Icons.arrow_back_ios_new,
    color: Colors.white,
    size: 16,
  );
  static const Icon _waterDropIcon = Icon(
    Icons.water_drop,
    size: 12,
    color: Color(0xFF38BDF8),
  );

  // Geometry Constants
  static const EdgeInsets _navBarPadding = EdgeInsets.symmetric(
    horizontal: _horizontalPadding,
    vertical: _verticalPadding,
  );
  static const BorderRadius _barBorderRadius = BorderRadius.all(
    Radius.circular(_borderRadius),
  );

  // Animation Constants
  static const Duration _fluidDuration = Duration(milliseconds: 360);
  static const Curve _fluidCurve = Cubic(0.25, 1.15, 0.3, 1.0);

  // Color Constants
  static const Color _selectedIconColor = Colors.white;
  static const Color _unselectedIconColor = Color(0x70FFFFFF);
  static const LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E1B4B), Color(0xFF311042)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const BoxDecoration _backgroundDecoration = BoxDecoration(
    gradient: _backgroundGradient,
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _animController = AnimationController(
      vsync: this,
      duration: _fluidDuration,
    );
    _fluidAnimation = CurvedAnimation(
      parent: _animController,
      curve: _fluidCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  /// Calculates the current center X position of the liquid indicator with seamless continuity.
  double _getCurrentCenterX(double itemWidth) {
    if (_dragX != null) return _dragX!;
    if (!_animController.isAnimating && _targetCenterX > 0) return _targetCenterX;
    final progress = _fluidAnimation.value;
    return lerpDouble(_startCenterX, _targetCenterX, progress) ??
        (_selectedIndex * itemWidth + itemWidth / 2);
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.pages.length == widget.items.length,
      'Pages and navigation items must have the same length.',
    );
    return Scaffold(
      extendBody: true,
      appBar: _buildLiquidGlassAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Builds a floating Liquid Glass AppBar with refraction lighting and cyan glow.
  PreferredSizeWidget _buildLiquidGlassAppBar() {
    return PreferredSize(
      preferredSize: _appBarPreferredSize,
      child: SafeArea(
        child: Padding(
          padding: _appBarPadding,
          child: ClipRRect(
            borderRadius: _appBarBorderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: _blurSigma,
                sigmaY: _blurSigma,
              ),
              child: Container(
                height: _appBarInnerHeight,
                padding: _appBarInnerPadding,
                decoration: _appBarDecoration,
                child: Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
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
                          child: _backIcon,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    const Text('Liquid Glass UI', style: _appBarTitleStyle),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: _statusDecoration,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _waterDropIcon,
                          SizedBox(width: 4),
                          Text('Fluid', style: _statusTextStyle),
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

  /// Builds the main body using [PageView] for native hardware-accelerated page transitions.
  Widget _buildBody() {
    return Stack(
      children: [
        const DecoratedBox(
          decoration: _backgroundDecoration,
          child: SizedBox.expand(),
        ),
        PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: widget.pages,
        ),
      ],
    );
  }

  /// Builds the dynamic Liquid Glass bottom navigation bar.
  Widget _buildBottomNavigationBar() {
    return SafeArea(
      minimum: _navBarPadding,
      child: RepaintBoundary(
        child: ClipRRect(
          borderRadius: _barBorderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _blurSigma,
              sigmaY: _blurSigma,
            ),
            child: Container(
              height: _navigationBarHeight,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: _barBorderRadius,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.20),
                  width: _borderWidth,
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemCount = widget.items.length;
                  if (itemCount == 0) return const SizedBox();

                  final barWidth = constraints.maxWidth;
                  final itemWidth = barWidth / itemCount;

                  // Initialize target positions on first layout pass
                  if (_targetCenterX == 0) {
                    _startCenterX = (_selectedIndex * itemWidth) + (itemWidth / 2);
                    _targetCenterX = _startCenterX;
                  }

                  return GestureDetector(
                    key: const ValueKey('liquid_bottom_nav_bar_gesture'),
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragStart: (details) {
                      setState(() {
                        _isDragging = true;
                        _dragX = details.localPosition.dx.clamp(0.0, barWidth);
                      });
                    },
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        _dragX = details.localPosition.dx.clamp(0.0, barWidth);
                      });
                    },
                    onHorizontalDragEnd: (details) {
                      _handleDragEnd(barWidth, itemWidth);
                    },
                    onHorizontalDragCancel: () {
                      setState(() {
                        _isDragging = false;
                        _dragX = null;
                      });
                    },
                    child: Stack(
                      children: [
                        /// Animated GPU liquid painter (zero rebuilds of BackdropFilter)
                        AnimatedBuilder(
                          animation: _animController,
                          builder: (context, child) {
                            final currentCenterX = _getCurrentCenterX(itemWidth);
                            final lightX = (currentCenterX / barWidth).clamp(0.0, 1.0);
                            final animValue = _fluidAnimation.value;

                            return CustomPaint(
                              size: Size(barWidth, _navigationBarHeight),
                              painter: _LiquidGlassPainter(
                                currentCenterX: currentCenterX,
                                itemWidth: itemWidth,
                                lightX: lightX,
                                isDragging: _isDragging,
                                isAnimating: _animController.isAnimating,
                                animValue: animValue,
                              ),
                            );
                          },
                        ),

                        /// Interactive navigation tab icons.
                        Row(
                          children: List.generate(itemCount, (index) {
                            return Expanded(
                              child: _buildNavItem(
                                widget.items[index],
                                index,
                                itemWidth,
                              ),
                            );
                          }),
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

  /// Builds an individual navigation tab item with dynamic scaling and smooth icon transitions.
  Widget _buildNavItem(BottomNavigationItem item, int index, double itemWidth) {
    final isSelected = _selectedIndex == index;

    return InkWell(
      key: ValueKey('liquid_tab_item_${item.index}'),
      borderRadius: _barBorderRadius,
      onTap: () => _onItemTapped(index, itemWidth),
      child: Center(
        child: AnimatedScale(
          scale: isSelected ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Icon(
            isSelected ? item.selectedIcon : item.unselectedIcon,
            color: isSelected ? _selectedIconColor : _unselectedIconColor,
            size: _iconSize,
          ),
        ),
      ),
    );
  }

  /// Handles tap selection with seamless, jump-free spring animation and smooth page sliding.
  void _onItemTapped(int index, double itemWidth) {
    final target = (index * itemWidth) + (itemWidth / 2);
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

  /// Determines closest tab on drag release and animates smoothly from drop position to destination.
  void _handleDragEnd(double barWidth, double itemWidth) {
    if (_dragX == null) return;
    final calculatedIndex = (_dragX! / itemWidth).floor();
    final newIndex = calculatedIndex.clamp(0, widget.items.length - 1);
    final target = (newIndex * itemWidth) + (itemWidth / 2);

    final currentX = _dragX!;

    setState(() {
      _startCenterX = currentX;
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

/// Custom painter for Liquid Glass surface light refraction, edge highlights, and liquid selection pill.
class _LiquidGlassPainter extends CustomPainter {
  /// Current center X coordinate of the liquid indicator capsule.
  final double currentCenterX;

  /// Width of an individual tab item.
  final double itemWidth;

  /// Normalized X coordinate (0.0 to 1.0) of light source focal point.
  final double lightX;

  /// Whether user is currently dragging across the bar.
  final bool isDragging;

  /// Whether fluid transition animation is active.
  final bool isAnimating;

  /// Current progress (0.0 to 1.0) of the spring animation.
  final double animValue;

  /// Creates a [_LiquidGlassPainter].
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

    // 1. Dynamic light sheen highlight along top border of glass shell
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
        center: Alignment(
          (lightX * 2) - 1.0,
          -0.5,
        ),
        radius: isDragging ? 0.6 : 0.4,
        colors: [
          Colors.white.withValues(alpha: isDragging ? 0.18 : 0.08),
          Colors.transparent,
        ],
      ).createShader(rect);

    canvas.drawRRect(barRRect, lightSpotPaint);

    // 3. Render Liquid Selection Pill Capsule
    final stretchFactor = isAnimating
        ? math.sin(animValue * math.pi) * 0.20
        : (isDragging ? 0.10 : 0.0);

    final baseIndicatorWidth = itemWidth * 0.72;
    final indicatorWidth = baseIndicatorWidth * (1.0 + stretchFactor);
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

    // Outer cyan liquid glow
    final glowPaint = Paint()
      ..color = const Color(0x4038BDF8)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawRRect(pillRRect, glowPaint);

    // Liquid fill linear gradient
    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.35),
          Colors.white.withValues(alpha: 0.15),
        ],
        begin: Alignment(-1.0 + (lightX * 2), -1.0),
        end: Alignment(1.0 - (lightX * 2), 1.0),
      ).createShader(pillRect);
    canvas.drawRRect(pillRRect, fillPaint);

    // Inner radial specular highlight
    final specularPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment(-0.5 + lightX, -0.6),
        radius: 0.8,
        colors: [
          Colors.white.withValues(alpha: 0.45),
          Colors.transparent,
        ],
      ).createShader(pillRect);
    canvas.drawRRect(pillRRect, specularPaint);

    // Translucent border highlight
    final pillBorderPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.50),
          Colors.white.withValues(alpha: 0.20),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(pillRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRRect(pillRRect, pillBorderPaint);
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
  /// The icon displayed when the item is active/selected.
  final IconData selectedIcon;

  /// The icon displayed when the item is inactive/unselected.
  final IconData unselectedIcon;

  /// The label for the navigation item.
  final String label;

  /// The index position of the item in the navigation bar.
  final int index;

  /// Creates a [BottomNavigationItem] instance.
  const BottomNavigationItem({
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.index,
  });
}
