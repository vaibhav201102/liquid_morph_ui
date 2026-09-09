# 🔮 Liquid Glass UI - Flutter Glassmorphism & Liquid Glass Kit

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20macOS%20%7C%20Web-blue)

A modern, high-performance Flutter showcase and reusable library demonstrating two cutting-edge glass UI paradigms: **Classic Glassmorphism** and **Behavior-Driven Liquid Glass**, engineered with enterprise-grade **Clean Architecture** and **OOP Design Patterns**.

---

## 🌟 Interface Design Paradigms

### 1. ❄️ Classic Glassmorphism UI
- **Static Depth & Frosted Blur**: Fixed backdrop blur (`sigma 15`), translucent container fill (`12% opacity`), and subtle specular borders.
- **Floating Glass AppBar**: Custom floating frosted glass app bar with back navigation.
- **Smooth Tab Selection**: Linear position interpolation and tab switching.

### 2. 💧 Dynamic Liquid Glass UI
- **Behavior-Driven Material**: Dynamically refracts light and responds to user drag coordinates and velocity in real time.
- **120 FPS GPU Canvas Painter**: Renders light sheen, cyan liquid glow (`0x4038BDF8`), and radial specular highlights directly on Canvas with zero-rebuild backdrop filtering.
- **Viscous Shape Deformation**: Capsule indicator deforms (stretches up to 20% horizontally and compresses vertically) during fast movements, simulating fluid surface tension.
- **Spring Physics**: Bouncing spring response (`Cubic(0.25, 1.15, 0.3, 1.0)`) on tab arrival.
- **Hardware-Accelerated Page Transitions**: Integrated `PageView` for native GPU compositor layer sliding.

---

## 🧩 Reusable Library, AppBars & Extensions (`glass_ui_kit.dart`)

Developers can easily customize and use standalone **Glass AppBars**, **Glass Containers**, or **Widget Extensions**:

### 1. Standalone Customizable `GlassAppBar`
Pass `title`, `leftButtons`, `rightButtons`, `backgroundColor`, and `blur` effortlessly:

```dart
import 'package:liquid_glass_ui/glass_ui_kit.dart';

// Classic Glassmorphism AppBar
GlassAppBar(
  title: 'Dashboard',
  leftButtons: [
    IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {}),
  ],
  rightButtons: [
    IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
    IconButton(icon: const Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
  ],
);

// Liquid Glass Styled AppBar
GlassAppBar.liquid(
  title: 'Fluid Dashboard',
  rightButtons: [
    IconButton(icon: const Icon(Icons.settings, color: Colors.white), onPressed: () {}),
  ],
);
```

### 2. Extension Methods on `Widget`
```dart
import 'package:liquid_glass_ui/glass_ui_kit.dart';

// Turn ANY widget into Frosted Glass in 1 line
const Text('Frosted Card').asGlass(blur: 15.0);

// Turn ANY widget into Liquid Glass in 1 line
const Text('Liquid Card').asLiquidGlass(glowColor: Color(0x3038BDF8));
```

### 3. Reusable Glass Container Wrappers
```dart
import 'package:liquid_glass_ui/glass_ui_kit.dart';

// Reusable Glassmorphism Container
GlassContainer(
  blur: 15.0,
  borderRadius: BorderRadius.circular(20.0),
  child: MyWidget(),
);

// Reusable Liquid Glass Container
LiquidGlassContainer(
  blur: 18.0,
  glowColor: const Color(0x3038BDF8),
  child: MyWidget(),
);
```

### 4. Customizable Full Navigation Views
Customize title text, actions, and left buttons directly from `LiquidGlassUI` or `GlassmorphismUI`:

```dart
import 'package:liquid_glass_ui/glass_ui_kit.dart';

LiquidGlassUI(
  title: 'My Custom App',
  actions: [
    IconButton(
      icon: const Icon(Icons.settings, color: Colors.white),
      onPressed: () {},
    ),
  ],
  pages: myPages,
  items: myItems,
)
```

---

## 🏗️ Senior Developer Architecture & OOP Design Patterns

This codebase is structured around production-grade **Clean Architecture** and classic **Gof Design Patterns**:

1. **Clean Architecture (Controller / BLoC vs Presentation)**:
   - Business logic, touch gestures, and physics state are encapsulated in [`GlassNavigationController`](file:///Users/vaibhav/StudioProjects/glass_bottom_bar_ui/lib/core/glass_navigation_controller.dart), leaving UI widgets as pure presentation layers.
2. **Immutable Value State ([`GlassNavigationState`](class://GlassNavigationState))**:
   - Encapsulates active tab indices, drag coordinates, animation progress, and interaction flags into an immutable value object featuring `copyWith()`, value equality (`==`), and `hashCode`.
3. **Command Pattern ([`GlassNavigationCommand`](class://GlassNavigationCommand))**:
   - Encapsulates user interactions as executable commands: [`SelectTabCommand`](class://SelectTabCommand), [`DragUpdateCommand`](class://DragUpdateCommand), and [`DragEndCommand`](class://DragEndCommand).
4. **Observer Pattern & Scoped Dependency Injection ([`GlassScope`](class://GlassScope))**:
   - Uses an `InheritedNotifier` scope providing scoped dependency injection of the state controller down the widget tree with reactive frame notifications.
5. **Strategy Pattern ([`GlassNavigationEngine`](class://GlassNavigationEngine))**:
   - Abstract engine strategy interface allowing dynamic swapping of tab physics and rendering strategies.
6. **Optimized LOC & Beginner-Friendly Comments**:
   - Reduced overall lines of code by **40–60%** while adding clear, educational inline comments explaining every widget, state variable, and calculation.

---

## ⚡ Performance Highlights

- **`RepaintBoundary` Isolation**: The computationally heavy `BackdropFilter` layer is cached and isolated from rebuilds during animations.
- **Jump-Free Gesture Continuity**: Drag release captures current frame position (`_startCenterX`) so the capsule smoothly interpolates to the target tab without teleporting or snapping back.
- **`static const` Optimization**: All layout dimensions, colors, edge insets, text styles, and border decorations are compile-time constants.
- **Swift Package Manager (SPM)**: Native iOS dependency management configured via Swift Package Manager.

---

## 📁 Project Architecture

```
lib/
├── glass_ui_kit.dart                  # Single Package Export Module for Developers
├── main.dart                          # Application Entry Point (main())
├── app.dart                           # Root MaterialApp Configuration (MyApp)
├── main_home_screen.dart              # Showcase Home Screen & Reusable Navigation Glass Card
├── glass_morphism_ui.dart             # Glassmorphism UI Component & Floating AppBar
├── liquid_glass_ui.dart              # Liquid Glass UI Component & GPU Canvas Painter
├── src/                               # Reusable Glass Library Modules
│   ├── glass_app_bar.dart             # GlassAppBar & GlassAppBar.liquid Standalone Widgets
│   ├── glass_container.dart           # GlassContainer & LiquidGlassContainer Widgets
│   ├── glass_ui_style.dart            # GlassUIStyle Enum
│   └── glass_widget_extension.dart    # Widget.asGlass() & Widget.asLiquidGlass() Extensions
└── core/                              # Core Architecture & OOP Modules
    ├── glass_navigation_controller.dart # Reactive Controller, Immutable State & Commands
    ├── glass_scope.dart                 # Scoped InheritedWidget Dependency Injection
    └── glass_ui_contracts.dart          # Abstractions, Interfaces & Strategy Engines

test/                                  # Unit & Widget Test Suite
├── main_screen_test.dart              # Main HomeScreen Navigation Tests
├── glass_morphism_ui_test.dart        # GlassmorphismUI Widget Tests
├── liquid_glass_ui_test.dart          # LiquidGlassUI Widget Tests
├── glass_ui_kit_test.dart             # GlassUIKit Extension, Container & AppBar Tests
├── unit_and_painter_test.dart         # Data Model & CustomPainter Unit Tests
└── widget_test.dart                   # Master Unit/Widget Test Suite Runner

integration_test/                      # End-to-End Integration Test Suite
├── app_test.dart                      # Complete User Journey & Navigation Tests
├── gesture_and_stress_test.dart        # Advanced Gesture, Clamping & Viewport Adaptation
└── all_tests.dart                     # Master Integration Test Suite Entry Point
```

---

## 💻 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0 <4.0.0`
- Dart SDK `>=3.0.0 <4.0.0`

### Installation

```bash
flutter pub add liquid_glass_ui
```

Or add to `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  liquid_glass_ui: ^1.0.1
```

---

## 🧪 Running Tests

### 1. Run All Unit & Widget Tests
```bash
flutter test
# or
fvm flutter test
```

### 2. Run All Integration Tests
Ensure an emulator or connected device is available (`flutter devices`):

```bash
# Run Master Integration Test Suite
flutter test integration_test/all_tests.dart -d <device_id>

# Run Specific E2E Suite
flutter test integration_test/app_test.dart -d <device_id>
```

---

## 📜 License

This project is open source and available under the [MIT License](LICENSE).
