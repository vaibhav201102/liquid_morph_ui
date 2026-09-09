import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:liquid_glass_ui_kit/glass_ui_kit.dart';

void main() {
  runApp(const ExampleGlassApp());
}

/// Root example application showcasing Glassmorphism, Liquid Glass, and standalone GlassAppBar.
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

/// Main example hub screen offering live previews of both Glass UI styles and customizable Glass AppBars.
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
                    'Tap a card below to preview customized AppBars & Navigation UIs',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const Spacer(),

                  // Option 1: Glassmorphism UI with Custom AppBar Title & Actions
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GlassmorphismUI(
                            title: 'Frosted Dashboard',
                            actions: [
                              IconButton(
                                icon: const Icon(
                                  Icons.notifications_none,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
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
                                'Classic frosted glass with custom AppBar actions',
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

                  // Option 2: Liquid Glass UI with Custom Right Buttons
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LiquidGlassUI(
                            title: 'Fluid Dashboard',
                            actions: [
                              IconButton(
                                icon: const Icon(
                                  Icons.settings_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
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
                                'Dynamic liquid glass with custom settings action',
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

                  const Gap(20.0),

                  // Option 3: Standalone Custom GlassAppBar Screen Demo
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StandaloneAppBarDemoScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.web_asset,
                          size: 28,
                          color: Color(0xFFA855F7),
                        ),
                        const Gap(16.0),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Standalone GlassAppBar',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Gap(4.0),
                              Text(
                                'Plug-and-play GlassAppBar in standard Scaffold',
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

/// Demonstration of standalone [GlassAppBar.liquid] inside a standard Scaffold.
class StandaloneAppBarDemoScreen extends StatelessWidget {
  const StandaloneAppBarDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar.liquid(
        title: 'Standalone GlassAppBar',
        rightButtons: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
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
          Center(
            child: GlassContainer(
              padding: const EdgeInsets.all(24.0),
              borderRadius: BorderRadius.circular(24.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 48, color: Color(0xFF38BDF8)),
                  Gap(12.0),
                  Text(
                    'Standalone GlassAppBar Demo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(8.0),
                  Text(
                    'Custom leftButtons & rightButtons passed directly!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
