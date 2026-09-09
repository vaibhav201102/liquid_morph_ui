import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_glass_ui_kit/glass_ui_contracts.dart';
import 'package:liquid_glass_ui_kit/liquid_glass_ui.dart';
import 'package:liquid_glass_ui_kit/src/glass_app_bar.dart';

/// Glassmorphism UI Screen implementing [GlassUIContract].
///
/// Fully customizable from the outside:
/// - Pass custom [appBar] or [title]
/// - Pass custom [leading] or [actions]
class GlassmorphismUI extends StatefulWidget implements GlassUIContract {
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

  /// Creates a [GlassmorphismUI] widget.
  const GlassmorphismUI({
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
  State<GlassmorphismUI> createState() => _GlassmorphismUIState();
}

class _GlassmorphismUIState extends State<GlassmorphismUI> {
  late GlassNavigationController _controller;

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
  void initState() {
    super.initState();
    _controller = GlassNavigationController(itemCount: widget.items.length);
  }

  @override
  void dispose() {
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
                IndexedStack(
                  index: state.selectedIndex,
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
    return GlassAppBar(
      title: widget.title,
      titleWidget: widget.titleWidget,
      leading: widget.leading,
      actions: widget.actions,
      showBackButton: widget.showBackButton,
    );
  }

  Widget _buildBottomNavBar(BuildContext context, GlassNavigationState state) {
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
                  onHorizontalDragEnd: (d) => DragEndCommand(
                    barWidth: constraints.maxWidth,
                    itemWidth: itemWidth,
                  ).execute(_controller),
                  onHorizontalDragCancel: () => _controller.cancelDrag(),
                  child: Stack(
                    children: [
                      _buildSelectionCapsule(
                        state,
                        itemWidth,
                        constraints.maxWidth,
                      ),
                      Row(
                        children: widget.items
                            .map((item) => Expanded(
                                  child: _buildNavItem(
                                    context,
                                    item,
                                    state,
                                    itemWidth,
                                  ),
                                ))
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
    GlassNavigationState state,
    double itemWidth,
    double maxWidth,
  ) {
    final targetX = (state.selectedIndex * itemWidth) + (itemWidth / 2);
    final currentX = state.dragX ?? targetX;
    final width = itemWidth * 0.72;
    final left = (currentX - (width / 2)).clamp(0.0, maxWidth - width);

    return AnimatedPositioned(
      duration: state.isDragging
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

  Widget _buildNavItem(
    BuildContext context,
    BottomNavigationItem item,
    GlassNavigationState state,
    double itemWidth,
  ) {
    final isSelected = state.selectedIndex == item.index;
    return InkWell(
      key: ValueKey('glass_tab_item_${item.index}'),
      borderRadius: _pillRadius,
      onTap: () {
        SelectTabCommand(index: item.index, itemWidth: itemWidth)
            .execute(_controller);
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
}
