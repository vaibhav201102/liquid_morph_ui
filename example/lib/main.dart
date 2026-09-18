import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:liquid_morph_ui/glass_ui_kit.dart';

void main() {
  runApp(const ExampleGlassApp());
}

/// Root example application showcasing Glassmorphism, Liquid Glass, and Glass UI Components.
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

/// Main example hub screen offering live previews of all Glass UI components.
class ExampleHomeScreen extends StatelessWidget {
  const ExampleHomeScreen({super.key});

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
                    'Liquid Morph UI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(8.0),
                  Text(
                    'Select an interface design style below to explore its live components & dashboard',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const Spacer(),

                  // Option 1: Glassmorphism UI (Renders dynamic titles: Dashboard, Search, Favorites, Profile)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GlassmorphismUI(
                            titles: const [
                              'Dashboard',
                              'Search',
                              'Favorites',
                              'Profile',
                            ],
                            actions: [
                              IconButton(
                                icon: const Icon(
                                  Icons.notifications_none,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                            pages: AppSampleData.glassmorphismPages,
                            items: AppSampleData.items,
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
                                'Frosted dashboard with Glass Buttons, Switches & TextFields',
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

                  const Gap(16.0),

                  // Option 2: Liquid Glass UI (Renders dynamic titles: Dashboard, Search, Favorites, Profile)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LiquidGlassUI(
                            titles: const [
                              'Dashboard',
                              'Search',
                              'Favorites',
                              'Profile',
                            ],
                            actions: [
                              IconButton(
                                icon: const Icon(
                                  Icons.settings_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                            pages: AppSampleData.liquidPages,
                            items: AppSampleData.items,
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
                                'Liquid glass dashboard with Liquid Buttons & Glow Switches',
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

                  const Gap(16.0),

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
                                'Standalone Glass Components',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Gap(4.0),
                              Text(
                                'Independent GlassAppBar & LiquidGlassBottomNavBar',
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

/// Demonstration of standalone [GlassAppBar.liquid] and [LiquidGlassBottomNavBar] working independently.
class StandaloneAppBarDemoScreen extends StatefulWidget {
  const StandaloneAppBarDemoScreen({super.key});

  @override
  State<StandaloneAppBarDemoScreen> createState() =>
      _StandaloneAppBarDemoScreenState();
}

class _StandaloneAppBarDemoScreenState
    extends State<StandaloneAppBarDemoScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const LiquidGlassHomePageContent(title: 'Standalone Glass Dashboard'),
    const Center(
      child: Text(
        'Standalone Search Page',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
    const Center(
      child: Text(
        'Standalone Profile Page',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar.liquid(
        title: 'Standalone Glass Demo',
        rightButtons: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
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
          SafeArea(
            bottom: false,
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: LiquidGlassBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
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
            selectedIcon: Icons.person,
            unselectedIcon: Icons.person_outline,
            label: 'Profile',
            index: 2,
          ),
        ],
      ),
    );
  }
}
