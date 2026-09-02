import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glass_bottom_bar_ui/liquid_glass_ui.dart';
import 'package:glass_bottom_bar_ui/glass_morphism_ui.dart';

void main() {
  runApp(const MyApp());
}

/// Root application widget.
class MyApp extends StatelessWidget {
  static const Color _seedColor = Color(0xFF6A11CB);

  /// Creates [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass UI Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainHomeScreen(),
    );
  }
}

/// Main selection screen offering access to [GlassmorphismUI] and [LiquidGlassUI].
class MainHomeScreen extends StatelessWidget {
  /// Creates [MainHomeScreen].
  const MainHomeScreen({super.key});

  // Screen Constants
  static const List<Widget> _samplePages = [
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

  static const List<BottomNavigationItem> _sampleItems = [
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

  // Background Gradient Constants
  static const LinearGradient _backgroundGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E1B4B), Color(0xFF311042)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const BoxDecoration _backgroundDecoration = BoxDecoration(
    gradient: _backgroundGradient,
  );

  // Layout Constants
  static const EdgeInsets _screenPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 32.0,
  );
  static const TextStyle _titleStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
  );
  static const TextStyle _subtitleStyle = TextStyle(
    fontSize: 15,
    color: Color(0xB3FFFFFF),
  );

  // Card Gradient Constants
  static const List<Color> _glassmorphismGradient = [
    Color(0x802A5298),
    Color(0x4D1E3C72),
  ];
  static const List<Color> _liquidGlassGradient = [
    Color(0x806A11CB),
    Color(0x4D2575FC),
  ];

  // Card Layout & Decoration Constants
  static const double _cardRadius = 24.0;
  static const BorderRadius _cardBorderRadius = BorderRadius.all(
    Radius.circular(_cardRadius),
  );
  static const EdgeInsets _cardPadding = EdgeInsets.all(20.0);
  static const Color _cardBorderColor = Color(0x40FFFFFF);
  static const BorderSide _cardBorderSide = BorderSide(
    color: _cardBorderColor,
    width: 1.2,
  );
  static const Icon _appIcon = Icon(
    Icons.auto_awesome,
    size: 56.0,
    color: Color(0xFF38BDF8),
  );
  static const Icon _arrowIcon = Icon(
    Icons.arrow_forward_ios,
    color: Colors.white70,
    size: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Gradient background
          const DecoratedBox(
            decoration: _backgroundDecoration,
            child: SizedBox.expand(),
          ),

          SafeArea(
            child: Padding(
              padding: _screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24.0),
                  _appIcon,
                  const SizedBox(height: 16.0),
                  const Text(
                    'Glass UI Showcase',
                    textAlign: TextAlign.center,
                    style: _titleStyle,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Select an interface design style below to preview',
                    textAlign: TextAlign.center,
                    style: _subtitleStyle,
                  ),
                  const Spacer(),

                  /// Glassmorphism UI Button
                  _buildNavigationCard(
                    key: const ValueKey('glassmorphism_card_button'),
                    context: context,
                    title: 'Glassmorphism UI',
                    subtitle: 'Classic static translucent glass with frosted depth',
                    icon: Icons.layers_outlined,
                    gradientColors: _glassmorphismGradient,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const GlassmorphismUI(
                            pages: _samplePages,
                            items: _sampleItems,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20.0),

                  /// Liquid Glass UI Button
                  _buildNavigationCard(
                    key: const ValueKey('liquid_glass_card_button'),
                    context: context,
                    title: 'Liquid Glass UI',
                    subtitle: 'Dynamic behavior-driven glass with light refraction & spring physics',
                    icon: Icons.water_drop_outlined,
                    gradientColors: _liquidGlassGradient,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const LiquidGlassUI(
                            pages: _samplePages,
                            items: _sampleItems,
                          ),
                        ),
                      );
                    },
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

  /// Builds a modern glass-styled navigation card button.
  Widget _buildNavigationCard({
    Key? key,
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      key: key,
      borderRadius: _cardBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: _cardBorderRadius,
            splashColor: Colors.white.withValues(alpha: 0.1),
            highlightColor: Colors.white.withValues(alpha: 0.05),
            child: Container(
              padding: _cardPadding,
              decoration: BoxDecoration(
                borderRadius: _cardBorderRadius,
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: const Border.fromBorderSide(_cardBorderSide),
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
                  const SizedBox(width: 16.0),
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
                        const SizedBox(height: 4.0),
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
                  _arrowIcon,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
