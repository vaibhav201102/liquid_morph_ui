import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:liquid_morph_ui/glass_ui_kit.dart';

/// Pure Glassmorphism Home Page Content displaying ONLY Glassmorphism components.
class GlassmorphismHomePageContent extends StatefulWidget {
  final String title;

  const GlassmorphismHomePageContent({super.key, required this.title});

  @override
  State<GlassmorphismHomePageContent> createState() =>
      _GlassmorphismHomePageContentState();
}

class _GlassmorphismHomePageContentState
    extends State<GlassmorphismHomePageContent> {
  bool _switchVal = true;
  int _buttonTapCount = 0;
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    const topPadding = 76.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom + 90.0;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.0, topPadding, 20.0, bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Glassmorphism Header Card
          const Gap(40.0),

          GlassCard(
            child: Row(
              children: [
                const Icon(
                  Icons.layers_outlined,
                  color: Colors.white,
                  size: 32,
                ),
                const Gap(14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(2.0),
                      const Text(
                        'Pure Glassmorphism UI Suite',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Gap(20.0),

          // 1. Glassmorphism Buttons
          const Text(
            'GLASSmorphism BUTTONS',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          Row(
            children: [
              Expanded(
                child: GlassButton(
                  label: 'Frosted Action A',
                  icon: Icons.auto_awesome,
                  onTap: () => setState(() => _buttonTapCount++),
                ),
              ),
              const Gap(12.0),
              Expanded(
                child: GlassButton(
                  label: 'Frosted Action B',
                  icon: Icons.layers_outlined,
                  onTap: () => setState(() => _buttonTapCount++),
                ),
              ),
            ],
          ),
          const Gap(6.0),
          Text(
            'Button Taps Counter: $_buttonTapCount',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),

          const Gap(20.0),

          // 2. Glassmorphism Switch
          const Text(
            'GLASSmorphism TOGGLE SWITCH',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          GlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Frosted Glass Toggle: ${_switchVal ? "ON" : "OFF"}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                GlassSwitch(
                  value: _switchVal,
                  onChanged: (val) => setState(() => _switchVal = val),
                ),
              ],
            ),
          ),

          const Gap(20.0),

          // 3. Glassmorphism Text Field
          const Text(
            'GLASSmorphism INPUT TEXT FIELD',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          GlassTextField(
            hintText: 'Frosted Glassmorphism Search Input...',
            prefixIcon: Icons.search,
            onChanged: (val) => setState(() => _inputText = val),
          ),
          if (_inputText.isNotEmpty) ...[
            const Gap(6.0),
            Text(
              'Typed: $_inputText',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],

          const Gap(20.0),

          // 4. Glassmorphism Cards & Extension Method
          const Text(
            'GLASSmorphism CARDS & EXTENSION',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          Row(
            children: [
              Expanded(
                child: GlassCard(
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.layers, color: Colors.white, size: 24),
                      Gap(8.0),
                      Text(
                        'Glass Card Alpha',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Gap(2.0),
                      Text(
                        'Static frosted blur',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(12.0),
              Expanded(
                child: GlassCard(
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 24),
                      Gap(8.0),
                      Text(
                        'Glass Card Beta',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Gap(2.0),
                      Text(
                        'Specular border highlight',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(14.0),
          Center(
            child: const Text(
              'Extension .asGlass() Frosted Badge',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ).asGlass(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pure Liquid Glass Home Page Content displaying ONLY Liquid Glass components.
class LiquidGlassHomePageContent extends StatefulWidget {
  final String title;

  const LiquidGlassHomePageContent({super.key, required this.title});

  @override
  State<LiquidGlassHomePageContent> createState() =>
      _LiquidGlassHomePageContentState();
}

class _LiquidGlassHomePageContentState
    extends State<LiquidGlassHomePageContent> {
  bool _switchVal = true;
  int _buttonTapCount = 0;
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    const topPadding = 76.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom + 90.0;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.0, topPadding, 20.0, bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Liquid Glass Header Card
          const Gap(40.0),
          LiquidGlassCard(
            child: Row(
              children: [
                const Icon(
                  Icons.water_drop,
                  color: Color(0xFF38BDF8),
                  size: 32,
                ),
                const Gap(14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(2.0),
                      const Text(
                        'Dynamic Liquid Glass UI Suite',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Gap(20.0),

          // 1. Liquid Glass Buttons
          const Text(
            'LIQUID GLASS BUTTONS',
            style: TextStyle(
              color: Color(0xFF38BDF8),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          Row(
            children: [
              Expanded(
                child: LiquidGlassButton(
                  label: 'Liquid Action A',
                  icon: Icons.water_drop,
                  onTap: () => setState(() => _buttonTapCount++),
                ),
              ),
              const Gap(12.0),
              Expanded(
                child: LiquidGlassButton(
                  label: 'Liquid Action B',
                  icon: Icons.bolt,
                  glowColor: const Color(0x60A855F7),
                  onTap: () => setState(() => _buttonTapCount++),
                ),
              ),
            ],
          ),
          const Gap(6.0),
          Text(
            'Button Taps Counter: $_buttonTapCount',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),

          const Gap(20.0),

          // 2. Liquid Glass Switch
          const Text(
            'LIQUID GLASS TOGGLE SWITCH',
            style: TextStyle(
              color: Color(0xFF38BDF8),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          LiquidGlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Liquid Glow Toggle: ${_switchVal ? "ON" : "OFF"}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                LiquidGlassSwitch(
                  value: _switchVal,
                  onChanged: (val) => setState(() => _switchVal = val),
                ),
              ],
            ),
          ),

          const Gap(20.0),

          // 3. Liquid Glass Text Field
          const Text(
            'LIQUID GLASS INPUT TEXT FIELD',
            style: TextStyle(
              color: Color(0xFF38BDF8),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          LiquidGlassTextField(
            hintText: 'Liquid Glass Focus Glow Input...',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            onChanged: (val) => setState(() => _inputText = val),
          ),
          if (_inputText.isNotEmpty) ...[
            const Gap(6.0),
            Text(
              'Typed: $_inputText',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 11),
            ),
          ],

          const Gap(20.0),

          // 4. Liquid Glass Cards & Extension Method
          const Text(
            'LIQUID GLASS CARDS & EXTENSION',
            style: TextStyle(
              color: Color(0xFF38BDF8),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          Row(
            children: [
              Expanded(
                child: LiquidGlassCard(
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.water_drop, color: Color(0xFF38BDF8), size: 24),
                      Gap(8.0),
                      Text(
                        'Liquid Card Alpha',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Gap(2.0),
                      Text(
                        'Cyan liquid glow',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(12.0),
              Expanded(
                child: LiquidGlassCard(
                  glowColor: const Color(0x50A855F7),
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.auto_awesome, color: Color(0xFFA855F7), size: 24),
                      Gap(8.0),
                      Text(
                        'Liquid Card Beta',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Gap(2.0),
                      Text(
                        'Purple glow shadow',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(14.0),
          Center(
            child: const Text(
              'Extension .asLiquidGlass() Glow Badge',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ).asLiquidGlass(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pure Glassmorphism Search Screen Content
class GlassmorphismSearchContent extends StatefulWidget {
  const GlassmorphismSearchContent({super.key});

  @override
  State<GlassmorphismSearchContent> createState() =>
      _GlassmorphismSearchContentState();
}

class _GlassmorphismSearchContentState
    extends State<GlassmorphismSearchContent> {
  final TextEditingController _searchController = TextEditingController();

  static const List<String> _tags = [
    'Glass UI',
    'Frosted Blur',
    'Flutter 3',
    'BLoC Pattern',
    'Custom Painter',
  ];

  static final List<Map<String, String>> _categories = List.generate(
    60,
    (index) {
      final names = [
        'UI Components & Kits',
        'Glass Physics & Motion',
        'Clean Architecture',
        'Hardware Accelerated Renderers',
        'Swift Package Manager Integration',
        'Automated Test Pipeline',
        'Specular Border Highlight Shader',
        'Backdrop Blurring Filter Layer',
        'Dynamic Lens Specular Point',
        'Viscous Capsule Spring Engine',
      ];
      final name = names[index % names.length];
      return {
        'title': '$name #${index + 1}',
        'count': '${(index + 1) * 3 + 5} Frosted Items Available',
      };
    },
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom + 100.0;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.0, 118.0, 20.0, bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Frosted Glass Search Input Field
          GlassTextField(
            controller: _searchController,
            hintText: 'Search frosted glass components...',
            prefixIcon: Icons.search,
            onChanged: (val) => setState(() {}),
          ),

          const Gap(16.0),

          // Search Tags / Filter Chips
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _tags.map((tag) {
              return Text(
                '# $tag',
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ).asGlass(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
              );
            }).toList(),
          ),

          const Gap(24.0),

          const Text(
            'TRENDING FROSTED CATEGORIES',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),

          // Categories List
          ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const Gap(12.0),
            itemBuilder: (context, index) {
              final cat = _categories[index];
              return GlassCard(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.30),
                          width: 1.0,
                        ),
                      ),
                      child: const Icon(Icons.explore_outlined,
                          color: Colors.white, size: 22),
                    ),
                    const Gap(14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cat['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(2.0),
                          Text(
                            cat['count']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.white54, size: 14),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Pure Liquid Glass Search Screen Content
class LiquidGlassSearchContent extends StatefulWidget {
  const LiquidGlassSearchContent({super.key});

  @override
  State<LiquidGlassSearchContent> createState() =>
      _LiquidGlassSearchContentState();
}

class _LiquidGlassSearchContentState extends State<LiquidGlassSearchContent> {
  final TextEditingController _searchController = TextEditingController();

  static const List<String> _tags = [
    'Liquid Motion',
    'Cyan Glow',
    'Spring Physics',
    '120 FPS GPU',
    'Shaders',
  ];

  static final List<Map<String, String>> _categories = List.generate(
    60,
    (index) {
      final names = [
        'Fluid UI Components',
        'Light Refraction Physics',
        'Reactive BLoC Streams',
        'GPU Canvas Shaders',
        'Cyan Glow Light Engine',
        'Viscous Capsule Physics',
        'Spring Interpolator Modules',
        'Specular Sheen Highlighters',
        'Dynamic Glass Shells',
        'Zero-Latency Drag Physics',
      ];
      final name = names[index % names.length];
      return {
        'title': '$name #${index + 1}',
        'count': '${(index + 1) * 4 + 8} Liquid Widgets Available',
      };
    },
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom + 100.0;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.0, 118.0, 20.0, bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Liquid Glass Search Input Field with Cyan Focus Glow
          LiquidGlassTextField(
            controller: _searchController,
            hintText: 'Search liquid components, shaders, triggers...',
            prefixIcon: Icons.search,
            onChanged: (val) => setState(() {}),
          ),

          const Gap(16.0),

          // Liquid Search Tags / Filter Chips
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _tags.map((tag) {
              return Text(
                '# $tag',
                style: const TextStyle(
                  color: Color(0xFF38BDF8),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ).asLiquidGlass(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 6.0,
                ),
              );
            }).toList(),
          ),

          const Gap(24.0),

          const Text(
            'TRENDING LIQUID CATEGORIES',
            style: TextStyle(
              color: Color(0xFF38BDF8),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),

          // Categories List
          ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const Gap(12.0),
            itemBuilder: (context, index) {
              final cat = _categories[index];
              return LiquidGlassCard(
                padding: const EdgeInsets.all(16.0),
                glowColor: index.isEven
                    ? const Color(0x3038BDF8)
                    : const Color(0x40A855F7),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0x3038BDF8),
                        border: Border.all(
                          color: const Color(0x8038BDF8),
                          width: 1.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.explore_outlined,
                        color: Color(0xFF38BDF8),
                        size: 22,
                      ),
                    ),
                    const Gap(14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cat['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(2.0),
                          Text(
                            cat['count']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.white54, size: 14),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Glassmorphism Favorites Screen Edge-to-Edge ListView
class GlassmorphismFavoritesContent extends StatelessWidget {
  const GlassmorphismFavoritesContent({super.key});

  static final List<Map<String, String>> _favorites = List.generate(
    60,
    (index) {
      final items = [
        'Frosted Glass UI Kit',
        'Fluid Motion Physics Engine',
        'Clean Architecture Core',
        '120 FPS GPU Canvas Painter',
        'Swift Package Manager Integration',
        'E2E Integration Test Suite',
        'Dynamic Light Refraction Layer',
        'Specular Glow Highlight Shader',
        'Interactive Glassmorphism Card',
        'Liquid Glass Action Button',
        'Translucent Glass TextField',
        'Glowing Liquid Toggle Switch',
        'Floating Glass AppBar',
        'Bottom Navigation Controller',
        'Adaptive Window Size Manager',
        'Vector Icon Asset Library',
        'Custom Backdrop Filter Engine',
        'Zero-Latency Drag Controller',
        'Clamped Gesture Interpolator',
        'GPU Memory Leak Protection',
      ];
      final title = items[index % items.length];
      return {
        'title': '$title #${index + 1}',
        'subtitle':
            'High-performance frosted glass component item module #${index + 1}',
      };
    },
  );

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom + 90.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20.0, 118.0, 20.0, bottomPadding),
            itemCount: _favorites.length,
            separatorBuilder: (_, __) => const Gap(12.0),
            itemBuilder: (context, index) {
              final item = _favorites[index];
              return GlassCard(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.30),
                          width: 1.0,
                        ),
                      ),
                      child: const Icon(Icons.favorite, color: Colors.pinkAccent, size: 22),
                    ),
                    const Gap(14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(2.0),
                          Text(
                            item['subtitle']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.pinkAccent, size: 20),
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Liquid Glass Favorites Screen Edge-to-Edge ListView
class LiquidGlassFavoritesContent extends StatelessWidget {
  const LiquidGlassFavoritesContent({super.key});

  static final List<Map<String, String>> _favorites = List.generate(
    60,
    (index) {
      final items = [
        'Liquid Motion Physics Engine',
        'Frosted Glass UI Kit',
        '120 FPS GPU Canvas Painter',
        'Clean Architecture Core',
        'Swift Package Manager Integration',
        'E2E Integration Test Suite',
        'Cyan Glow Shadow Shader',
        'Viscous Capsule Spring Engine',
        'Light Refraction Lens Point',
        'Dynamic Shell Container',
        'Focus Glow Text Field Input',
        'Glow Switch Slider Control',
        'Floating Liquid Glass AppBar',
        'Fluid Bottom Bar Controller',
        'Adaptive Screen Aspect Ratio',
        'Particle Canvas Renderer',
        'Custom Backdrop Blur Filter',
        'Interactive Drag Touch Listener',
        'Out-of-Bounds Drag Clamping',
        'Hardware Canvas Accelerator',
      ];
      final title = items[index % items.length];
      return {
        'title': '$title #${index + 1}',
        'subtitle':
            'Dynamic liquid glass component item module #${index + 1}',
      };
    },
  );

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom + 90.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20.0, 118.0, 20.0, bottomPadding),
            itemCount: _favorites.length,
            separatorBuilder: (_, __) => const Gap(12.0),
            itemBuilder: (context, index) {
              final item = _favorites[index];
              return LiquidGlassCard(
                padding: const EdgeInsets.all(16.0),
                glowColor: index.isEven
                    ? const Color(0x3038BDF8)
                    : const Color(0x40A855F7),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0x3038BDF8),
                        border: Border.all(
                          color: const Color(0x8038BDF8),
                          width: 1.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.water_drop,
                        color: Color(0xFF38BDF8),
                        size: 22,
                      ),
                    ),
                    const Gap(14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(2.0),
                          Text(
                            item['subtitle']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Color(0xFF38BDF8), size: 20),
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Glassmorphism Profile Screen Content with Static Glass Profile Avatar
class GlassmorphismProfileContent extends StatelessWidget {
  const GlassmorphismProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20.0, 118.0, 20.0, 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Static Glass Profile Avatar Card
          GlassCard(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Static Avatar Icon Circle
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.18),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.40),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                const Gap(16.0),
                const Text(
                  'Vaibhav Joshi',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Gap(4.0),
                const Text(
                  'Senior Flutter Developer',
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
                const Gap(12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'PRO MEMBER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ).asGlass(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Gap(20.0),

          // Section 1: Account Settings
          const Text(
            'ACCOUNT SETTINGS',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          GlassCard(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildOptionRow(Icons.person_outline, 'Edit Profile'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.lock_outline, 'Privacy & Security'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.notifications_none, 'Push Notifications'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.credit_card_outlined, 'Payment Methods'),
              ],
            ),
          ),

          const Gap(20.0),

          // Section 2: Preferences & Support
          const Text(
            'PREFERENCES & SUPPORT',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          GlassCard(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildOptionRow(Icons.language_outlined, 'Language & Region'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.palette_outlined, 'Appearance & Theme'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.help_outline, 'Help & Support Center'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.description_outlined, 'Terms & Privacy Policy'),
              ],
            ),
          ),

          const Gap(24.0),

          // Logout Button
          GlassButton(
            label: 'Logout Account',
            icon: Icons.logout,
            color: Colors.redAccent.withValues(alpha: 0.20),
            borderColor: Colors.redAccent.withValues(alpha: 0.40),
            onTap: () {},
          ),
          const Gap(24.0),

        ],
      ),
    );
  }

  Widget _buildOptionRow(IconData icon, String title) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 22),
            const Gap(14.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 14),
          ],
        ),
      ),
    );
  }
}

/// Liquid Glass Profile Screen Content with Static Cyan Glowing Glass Profile Avatar
class LiquidGlassProfileContent extends StatelessWidget {
  const LiquidGlassProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20.0, 118.0, 20.0, 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Static Liquid Glass Profile Avatar Card
          LiquidGlassCard(
            padding: const EdgeInsets.all(24.0),
            glowColor: const Color(0x4038BDF8),
            child: Column(
              children: [
                // Static Avatar Icon Circle with Cyan Liquid Glow
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0x3038BDF8),
                    border: Border.all(
                      color: const Color(0xFF38BDF8),
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x5038BDF8),
                        blurRadius: 16,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 64,
                    color: Color(0xFF38BDF8),
                  ),
                ),
                const Gap(16.0),
                const Text(
                  'Vaibhav Joshi',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Gap(4.0),
                const Text(
                  'Senior Flutter Developer',
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
                const Gap(12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'FLUID PRO MEMBER',
                      style: TextStyle(
                        color: Color(0xFF38BDF8),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ).asLiquidGlass(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 6.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Gap(20.0),

          // Section 1: Account Settings Card
          const Text(
            'ACCOUNT SETTINGS',
            style: TextStyle(
              color: Color(0xFF38BDF8),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          LiquidGlassCard(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildOptionRow(Icons.person_outline, 'Edit Profile'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.lock_outline, 'Privacy & Security'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.notifications_none, 'Push Notifications'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.credit_card_outlined, 'Payment Methods'),
              ],
            ),
          ),

          const Gap(20.0),

          // Section 2: Preferences & Support Card
          const Text(
            'PREFERENCES & SUPPORT',
            style: TextStyle(
              color: Color(0xFF38BDF8),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(10.0),
          LiquidGlassCard(
            padding: const EdgeInsets.all(16.0),
            glowColor: const Color(0x40A855F7),
            child: Column(
              children: [
                _buildOptionRow(Icons.language_outlined, 'Language & Region'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.palette_outlined, 'Appearance & Theme'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.help_outline, 'Help & Support Center'),
                const Divider(color: Colors.white24, height: 20),
                _buildOptionRow(Icons.description_outlined, 'Terms & Privacy Policy'),
              ],
            ),
          ),

          const Gap(24.0),

          // Logout Button
          LiquidGlassButton(
            label: 'Logout Account',
            icon: Icons.logout,
            glowColor: const Color(0x50EF4444),
            onTap: () {},
          ),
          const Gap(24.0),

        ],
      ),
    );
  }

  Widget _buildOptionRow(IconData icon, String title) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF38BDF8), size: 22),
            const Gap(14.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 14),
          ],
        ),
      ),
    );
  }
}

/// Sample Data Provider
/// Provides mock screens and navigation icons for demonstration.
abstract class AppSampleData {
  /// Glassmorphism pages
  static final List<Widget> glassmorphismPages = [
    const GlassmorphismHomePageContent(title: 'Home Screen'),
    const GlassmorphismSearchContent(),
    const GlassmorphismFavoritesContent(),
    const GlassmorphismProfileContent(),
  ];

  /// Liquid Glass pages
  static final List<Widget> liquidPages = [
    const LiquidGlassHomePageContent(title: 'Home Screen'),
    const LiquidGlassSearchContent(),
    const LiquidGlassFavoritesContent(),
    const LiquidGlassProfileContent(),
  ];

  /// Sample bottom navigation icons (Active vs Inactive icons)
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

/// Main Selection Home Hub Screen
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
          // Background Gradient
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
                    'Liquid Morph UI',
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
                    'Select an interface design style below to explore its live components & dashboard',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const Spacer(),

                  // Option 1: Glassmorphism UI
                  NavigationGlassCard(
                    key: const ValueKey('glassmorphism_card_button'),
                    title: 'Glassmorphism UI View',
                    subtitle:
                        'Frosted glass dashboard with Glass Buttons, Switches, Cards & TextFields',
                    icon: Icons.layers_outlined,
                    colors: const [Color(0x802A5298), Color(0x4D1E3C72)],
                    targetScreen: GlassmorphismUI(
                      pages: AppSampleData.glassmorphismPages,
                      items: AppSampleData.items,
                    ),
                  ),

                  const Gap(20.0),

                  // Option 2: Liquid Glass UI
                  NavigationGlassCard(
                    key: const ValueKey('liquid_glass_card_button'),
                    title: 'Liquid Glass UI View',
                    subtitle:
                        'Liquid glass dashboard with Liquid Buttons, Glow Switches & TextFields',
                    icon: Icons.water_drop_outlined,
                    colors: const [Color(0x806A11CB), Color(0x4D2575FC)],
                    targetScreen: LiquidGlassUI(
                      pages: AppSampleData.liquidPages,
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

/// Reusable Glass Navigation Button Card
class NavigationGlassCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;
  final Widget targetScreen;

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
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => targetScreen),
            ),
            borderRadius: BorderRadius.circular(20.0),
            splashColor: Colors.white.withValues(alpha: 0.1),
            child: Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
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
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1.0,
                      ),
                    ),
                    child: Icon(icon, color: Colors.white, size: 26),
                  ),
                  const Gap(14.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Gap(4.0),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 16,
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
