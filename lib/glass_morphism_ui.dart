import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glass_bottom_bar_ui/liquid_glass_ui.dart';

/// A widget that displays a classic glassmorphism styled bottom navigation bar UI.
///
/// Features a static gradient background, draggable item selection,
/// and a blurred translucent navigation bar & app bar.
class GlassmorphismUI extends StatefulWidget {
  /// List of page widgets corresponding to each tab index.
  final List<Widget> pages;

  /// Configuration items for each bottom navigation tab.
  final List<BottomNavigationItem> items;

  /// Creates a [GlassmorphismUI] widget.
  const GlassmorphismUI({
    super.key,
    required this.pages,
    required this.items,
  });

  @override
  State<GlassmorphismUI> createState() => _GlassmorphismUIState();
}

/// State for [GlassmorphismUI].
class _GlassmorphismUIState extends State<GlassmorphismUI> {
  /// Index of the currently selected navigation tab.
  int _selectedIndex = 0;

  /// Current drag position of the selection indicator.
  double? _dragPosition;

  // UI Constants
  static const double _borderRadius = 50.0;
  static const double _iconSize = 25.0;
  static const double _navigationBarHeight = 70.0;
  static const double _horizontalPadding = 40.0;
  static const double _verticalPadding = 12.0;
  static const double _blurSigma = 15.0;
  static const double _borderWidth = 1.2;

  // AppBar Constants
  static const double _appBarHeight = 64.0;
  static const double _appBarInnerHeight = 56.0;
  static const double _appBarRadius = 24.0;
  static const Size _appBarPreferredSize = Size.fromHeight(_appBarHeight);
  static const EdgeInsets _appBarPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 4.0,
  );
  static const EdgeInsets _appBarInnerPadding = EdgeInsets.symmetric(
    horizontal: 8.0,
  );
  static const BorderRadius _appBarBorderRadius = BorderRadius.all(
    Radius.circular(_appBarRadius),
  );
  static const Color _appBarBackgroundColor = Color(0x1FFFFFFF);
  static const Color _appBarBorderColor = Color(0x40FFFFFF);
  static const BorderSide _appBarBorderSide = BorderSide(
    color: _appBarBorderColor,
    width: _borderWidth,
  );
  static const Border _appBarBorder = Border.fromBorderSide(_appBarBorderSide);
  static const BoxDecoration _appBarDecoration = BoxDecoration(
    color: _appBarBackgroundColor,
    borderRadius: _appBarBorderRadius,
    border: _appBarBorder,
  );
  static const TextStyle _appBarTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const Icon _backIcon = Icon(
    Icons.arrow_back_ios_new,
    color: Colors.white,
    size: 18,
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
  static const Duration _itemAnimationDuration = Duration(milliseconds: 300);
  static const Duration _iconAnimationDuration = Duration(milliseconds: 200);
  static const Curve _itemAnimationCurve = Curves.easeInOut;

  // Color Constants
  static const Color _selectedIconColor = Colors.white;
  static const Color _unselectedIconColor = Color(0x66FFFFFF);
  static const Color _navBarBackgroundColor = Color(0x1FFFFFFF);
  static const Color _navBarBorderColor = Color(0x40FFFFFF);
  static const Color _selectedItemBackgroundColor = Color(0x33FFFFFF);
  static const BorderSide _navBarBorderSide = BorderSide(
    color: _navBarBorderColor,
    width: _borderWidth,
  );
  static const Border _navBarBorder = Border.fromBorderSide(_navBarBorderSide);
  static const BoxDecoration _navBarDecoration = BoxDecoration(
    color: _navBarBackgroundColor,
    borderRadius: _barBorderRadius,
    border: _navBarBorder,
  );

  // Background Constants
  static const LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF6A11CB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const BoxDecoration _backgroundDecoration = BoxDecoration(
    gradient: _backgroundGradient,
  );

  @override
  Widget build(BuildContext context) {
    assert(
      widget.pages.length == widget.items.length,
      'Pages and navigation items must have the same length.',
    );
    return Scaffold(
      extendBody: true,
      appBar: _buildGlassmorphismAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Builds a floating frosted glassmorphism AppBar.
  PreferredSizeWidget _buildGlassmorphismAppBar() {
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
                    IconButton(
                      key: const ValueKey('glass_app_bar_back_button'),
                      icon: _backIcon,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8.0),
                    const Text('Glassmorphism UI', style: _appBarTitleStyle),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the main body.
  Widget _buildBody() {
    return Stack(
      children: [
        const DecoratedBox(
          decoration: _backgroundDecoration,
          child: SizedBox.expand(),
        ),
        IndexedStack(index: _selectedIndex, children: widget.pages),
      ],
    );
  }

  /// Builds the glassmorphic bottom navigation bar.
  Widget _buildBottomNavigationBar() {
    return SafeArea(
      minimum: _navBarPadding,
      child: ClipRRect(
        borderRadius: _barBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: _blurSigma,
            sigmaY: _blurSigma,
          ),
          child: Container(
            height: _navigationBarHeight,
            decoration: _navBarDecoration,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemCount = widget.items.length;
                if (itemCount == 0) {
                  return const SizedBox();
                }
                final itemWidth = constraints.maxWidth / itemCount;
                return GestureDetector(
                  key: const ValueKey('glass_bottom_nav_bar_gesture'),
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragStart: (details) {
                    setState(() {
                      _dragPosition = details.localPosition.dx;
                    });
                  },
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _dragPosition = details.localPosition.dx.clamp(
                        0.0,
                        constraints.maxWidth,
                      );
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    _handleDragEnd(constraints.maxWidth, itemWidth);
                  },
                  onHorizontalDragCancel: () {
                    setState(() {
                      _dragPosition = null;
                    });
                  },
                  child: Stack(
                    children: [
                      /// Draggable selection indicator.
                      _buildSelectionIndicator(
                        itemWidth: itemWidth,
                        maxWidth: constraints.maxWidth,
                      ),

                      /// Navigation icons.
                      Row(
                        children: List.generate(itemCount, (index) {
                          return Expanded(
                            child: _buildNavItem(widget.items[index]),
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
    );
  }

  /// Builds the animated selection capsule.
  Widget _buildSelectionIndicator({
    required double itemWidth,
    required double maxWidth,
  }) {
    final selectedPosition = (_selectedIndex * itemWidth) + (itemWidth / 2);
    final currentPosition = _dragPosition ?? selectedPosition;
    final indicatorWidth = itemWidth * 0.72;
    final left = (currentPosition - (indicatorWidth / 2)).clamp(
      0.0,
      maxWidth - indicatorWidth,
    );
    return AnimatedPositioned(
      duration: _dragPosition != null ? Duration.zero : _itemAnimationDuration,
      curve: _itemAnimationCurve,
      left: left,
      top: 8,
      bottom: 8,
      width: indicatorWidth,
      child: IgnorePointer(
        child: Container(
          decoration: const BoxDecoration(
            color: _selectedItemBackgroundColor,
            borderRadius: _barBorderRadius,
          ),
        ),
      ),
    );
  }

  /// Builds an individual navigation item.
  Widget _buildNavItem(BottomNavigationItem item) {
    final isSelected = _selectedIndex == item.index;
    return InkWell(
      key: ValueKey('glass_tab_item_${item.index}'),
      borderRadius: _barBorderRadius,
      onTap: () => _onItemTapped(item.index),
      child: Center(
        child: AnimatedSwitcher(
          duration: _iconAnimationDuration,
          child: Icon(
            isSelected ? item.selectedIcon : item.unselectedIcon,
            key: ValueKey<bool>(isSelected),
            color: isSelected ? _selectedIconColor : _unselectedIconColor,
            size: _iconSize,
          ),
        ),
      ),
    );
  }

  /// Handles tab selection.
  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _dragPosition = null;
      _selectedIndex = index;
    });
  }

  /// Determines the nearest item when the user releases the drag.
  void _handleDragEnd(double maxWidth, double itemWidth) {
    if (_dragPosition == null) return;
    final calculatedIndex = (_dragPosition! / itemWidth).floor();
    final newIndex = calculatedIndex.clamp(0, widget.items.length - 1);
    setState(() {
      _selectedIndex = newIndex;
      _dragPosition = null;
    });
  }
}
