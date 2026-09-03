import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glass_bottom_bar_ui/glass_ui_contracts.dart';
import 'package:glass_bottom_bar_ui/liquid_glass_ui.dart';

/// Glassmorphism UI Screen implementing [GlassUIContract].
///
/// OOP PATTERNS USED:
/// 1. Abstraction (conforms to [GlassUIContract])
/// 2. Encapsulation (gesture math encapsulated in [TabGesturePhysics])
/// 3. Factory Pattern (uses [GlassThemeFactory])
class GlassmorphismUI extends StatefulWidget implements GlassUIContract {
  @override
  final List<Widget> pages;

  @override
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

class _GlassmorphismUIState extends State<GlassmorphismUI> {
  int _selectedIndex = 0; // Active tab index
  double? _dragPosition; // Current X position in pixels

  static const double _blurSigma = 15.0;
  static const double _borderRadius = 50.0;
  static const BorderRadius _pillRadius = BorderRadius.all(
    Radius.circular(_borderRadius),
  );

  static const BoxDecoration _bgDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF6A11CB)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

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
          IndexedStack(index: _selectedIndex, children: widget.pages),
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
            borderRadius: BorderRadius.circular(24.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
              child: Container(
                height: 56.0,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: GlassThemeFactory.createShellDecoration(
                  color: const Color(0x1FFFFFFF),
                  borderColor: const Color(0x40FFFFFF),
                  borderRadius: 24.0,
                  borderWidth: 1.2,
                ),
                child: Row(
                  children: [
                    IconButton(
                      key: const ValueKey('glass_app_bar_back_button'),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Gap(8.0),
                    const Text(
                      'Glassmorphism UI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
      minimum: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
      child: ClipRRect(
        borderRadius: _pillRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
          child: Container(
            height: 70.0,
            decoration: GlassThemeFactory.createShellDecoration(
              color: const Color(0x1FFFFFFF),
              borderColor: const Color(0x40FFFFFF),
              borderRadius: _borderRadius,
              borderWidth: 1.2,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final count = widget.items.length;
                if (count == 0) return const Offstage();
                final itemWidth = constraints.maxWidth / count;
                final physics = TabGesturePhysics(itemCount: count);

                return GestureDetector(
                  key: const ValueKey('glass_bottom_nav_bar_gesture'),
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragStart: (d) =>
                      setState(() => _dragPosition = d.localPosition.dx),
                  onHorizontalDragUpdate: (d) => setState(
                    () => _dragPosition = d.localPosition.dx.clamp(
                      0.0,
                      constraints.maxWidth,
                    ),
                  ),
                  onHorizontalDragEnd: (d) =>
                      _onDragEnd(physics, constraints.maxWidth, itemWidth),
                  onHorizontalDragCancel: () =>
                      setState(() => _dragPosition = null),
                  child: Stack(
                    children: [
                      _buildSelectionCapsule(
                        physics,
                        itemWidth,
                        constraints.maxWidth,
                      ),
                      Row(
                        children: widget.items
                            .map((item) => Expanded(child: _buildNavItem(item)))
                            .toList(),
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

  Widget _buildSelectionCapsule(
    TabGesturePhysics physics,
    double itemWidth,
    double maxWidth,
  ) {
    final targetX = physics.calculateTargetX(_selectedIndex, itemWidth);
    final currentX = _dragPosition ?? targetX;
    final width = itemWidth * 0.72;
    final left = physics.clampLeft(currentX, width, maxWidth);

    return AnimatedPositioned(
      duration: _dragPosition != null
          ? Duration.zero
          : const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: left,
      top: 8,
      bottom: 8,
      width: width,
      child: IgnorePointer(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: _pillRadius,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BottomNavigationItem item) {
    final isSelected = _selectedIndex == item.index;
    return InkWell(
      key: ValueKey('glass_tab_item_${item.index}'),
      borderRadius: _pillRadius,
      onTap: () {
        if (_selectedIndex == item.index) return;
        setState(() {
          _dragPosition = null;
          _selectedIndex = item.index;
        });
      },
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            isSelected ? item.selectedIcon : item.unselectedIcon,
            key: ValueKey<bool>(isSelected),
            color: isSelected ? Colors.white : const Color(0x66FFFFFF),
            size: 25.0,
          ),
        ),
      ),
    );
  }

  void _onDragEnd(
    TabGesturePhysics physics,
    double maxWidth,
    double itemWidth,
  ) {
    if (_dragPosition == null) return;
    final newIndex = physics.calculateIndex(_dragPosition!, itemWidth);
    setState(() {
      _selectedIndex = newIndex;
      _dragPosition = null;
    });
  }
}
