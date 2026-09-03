import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glass_bottom_bar_ui/glass_morphism_ui.dart';
import 'package:glass_bottom_bar_ui/liquid_glass_ui.dart';

/// Sample data provider for navigation pages and items.
abstract class AppSampleData {
  static const List<Widget> pages = [
    Center(
      child: Text(
        'Home Screen',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    Center(
      child: Text(
        'Search Screen',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    Center(
      child: Text(
        'Favorites Screen',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ];

  static const List<BottomNavigationItem> items = [
    BottomNavigationItem(
      selectedIcon: Icons.home,
      unselectedIcon: Icons.home_outlined,
      label: 'Home',
      index: 0,
    ),
    BottomNavigationItem(
      selectedIcon: Icons.search,
      unselectedIcon: Icons.search_outlined,
      label: 'Search',
      index: 1,
    ),
    BottomNavigationItem(
      selectedIcon: Icons.favorite,
      unselectedIcon: Icons.favorite_border,
      label: 'Favorites',
      index: 2,
    ),
    BottomNavigationItem(
      selectedIcon: Icons.person,
      unselectedIcon: Icons.person_outline,
      label: 'Profile',
      index: 3,
    ),
  ];
}

/// Main selection screen offering access to [GlassmorphismUI] and [LiquidGlassUI].
class MainHomeScreen extends StatelessWidget {
  /// Creates [MainHomeScreen].
  const MainHomeScreen({super.key});

  static const _bgDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF0F172A), Color(0xFF1E1B4B), Color(0xFF311042)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(decoration: _bgDecoration),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(24.0),
                  const Icon(
                    Icons.auto_awesome,
                    size: 56.0,
                    color: Color(0xFF38BDF8),
                  ),
                  const Gap(16.0),
                  const Text(
                    'Glass UI Showcase',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Gap(8.0),
                  Text(
                    'Select an interface design style below to preview',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const Spacer(),
                  const NavigationGlassCard(
                    key: ValueKey('glassmorphism_card_button'),
                    title: 'Glassmorphism UI',
                    subtitle:
                        'Classic static translucent glass with frosted depth',
                    icon: Icons.layers_outlined,
                    colors: [Color(0x802A5298), Color(0x4D1E3C72)],
                    targetScreen: GlassmorphismUI(
                      pages: AppSampleData.pages,
                      items: AppSampleData.items,
                    ),
                  ),
                  const Gap(20.0),
                  const NavigationGlassCard(
                    key: ValueKey('liquid_glass_card_button'),
                    title: 'Liquid Glass UI',
                    subtitle:
                        'Dynamic behavior-driven glass with light refraction & spring physics',
                    icon: Icons.water_drop_outlined,
                    colors: [Color(0x806A11CB), Color(0x4D2575FC)],
                    targetScreen: LiquidGlassUI(
                      pages: AppSampleData.pages,
                      items: AppSampleData.items,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable glassmorphic navigation button card.
class NavigationGlassCard extends StatelessWidget {
  /// Card title text.
  final String title;

  /// Card subtitle text.
  final String subtitle;

  /// Leading icon data.
  final IconData icon;

  /// Gradient background colors.
  final List<Color> colors;

  /// Target screen widget to navigate to on tap.
  final Widget targetScreen;

  /// Creates a [NavigationGlassCard].
  const NavigationGlassCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
    required this.targetScreen,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => targetScreen),
            ),
            borderRadius: BorderRadius.circular(24.0),
            splashColor: Colors.white.withValues(alpha: 0.1),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1.0,
                      ),
                    ),
                    child: Icon(icon, color: Colors.white, size: 28),
                  ),
                  const Gap(16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(4.0),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.7),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
