import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glass_bottom_bar_ui/glass_ui_kit.dart';

void main() {
  runApp(const ExampleGlassApp());
}

/// Root example application showcasing Glassmorphism and Liquid Glass.
class ExampleGlassApp extends StatelessWidget {
  const ExampleGlassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass UI Kit Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A11CB),
          brightness: Brightness.dark,
        ),
      ),
      home: const ExampleHomeScreen(),
    );
  }
}

/// Main example hub screen offering live previews of both Glass UI styles.
class ExampleHomeScreen extends StatelessWidget {
  const ExampleHomeScreen({super.key});

  static const List<Widget> _samplePages = [
    Center(
      child: Text(
        'Home Screen',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Center(
      child: Text(
        'Search Screen',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Center(
      child: Text(
        'Favorites Screen',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F172A),
                    Color(0xFF1E1B4B),
                    Color(0xFF311042),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(16.0),
                  const Icon(
                    Icons.auto_awesome,
                    size: 52.0,
                    color: Color(0xFF38BDF8),
                  ),
                  const Gap(12.0),
                  const Text(
                    'Glass UI Kit Examples',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(8.0),
                  Text(
                    'Tap a card below to experience the UI style',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const Spacer(),

                  // Glassmorphism Demo Button (Using .asGlass Extension)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GlassmorphismUI(
                            pages: _samplePages,
                            items: _sampleItems,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.layers_outlined,
                          size: 28,
                          color: Colors.white,
                        ),
                        const Gap(16.0),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Glassmorphism UI',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Gap(4.0),
                              Text(
                                'Classic frosted glass depth & static blur',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.white70,
                        ),
                      ],
                    ).asGlass(
                      borderRadius: BorderRadius.circular(20.0),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  ),

                  const Gap(20.0),

                  // Liquid Glass Demo Button (Using .asLiquidGlass Extension)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LiquidGlassUI(
                            pages: _samplePages,
                            items: _sampleItems,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.water_drop_outlined,
                          size: 28,
                          color: Color(0xFF38BDF8),
                        ),
                        const Gap(16.0),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Liquid Glass UI',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Gap(4.0),
                              Text(
                                'Dynamic behavior-driven glass with light refraction',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.white70,
                        ),
                      ],
                    ).asLiquidGlass(
                      borderRadius: BorderRadius.circular(20.0),
                      glowColor: const Color(0x3038BDF8),
                      padding: const EdgeInsets.all(20.0),
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
