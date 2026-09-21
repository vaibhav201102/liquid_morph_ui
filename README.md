# 🔮 Liquid Morph UI - Flutter Glassmorphism & Liquid Glass Kit

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Pub Version](https://img.shields.io/pub/v/liquid_morph_ui?logo=flutter)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20macOS%20%7C%20Web-blue)

A modern, high-performance Flutter showcase and reusable UI kit demonstrating two cutting-edge glass UI paradigms: **Classic Glassmorphism** and **Behavior-Driven Liquid Glass**, engineered with enterprise-grade **Clean Architecture** and **OOP Design Patterns**.

---

## 📱 Visual Previews & Screenshots

### 1. Main Selection Hub
![Main Selection Hub Screen](https://4wnv1si1gw.ufs.sh/f/AggufDazdUmO8Ldq2xyACVIX4sRmNDZGiuPtMjYezhHd6oTp)

### 2. Glassmorphism vs Liquid Glass Home Dashboards
| Glassmorphism Home View | Liquid Glass Home View |
| :---: | :---: |
| ![Glassmorphism Home Screen](https://4wnv1si1gw.ufs.sh/f/AggufDazdUmOOZzaNZVCsVohSJulniHkjm02AdLcxz7b5Dtv) | ![Liquid Glass Home Screen](https://4wnv1si1gw.ufs.sh/f/AggufDazdUmOyc54YQUQ7JaSYyIet5ow6uWM8v4KRHPZlAOU) |
| **Frosted Glass Dashboard** | **Dynamic Liquid Glass Dashboard** |

### 3. Search & Discovery Screens
| Glassmorphism Search View | Liquid Glass Search View |
| :---: | :---: |
| ![Glassmorphism Search Screen](https://4wnv1si1gw.ufs.sh/f/AggufDazdUmOYkamiCTcGeEDHsvP6omVBLYd4lzpuirINJ2k) | ![Liquid Glass Search Screen](https://4wnv1si1gw.ufs.sh/f/AggufDazdUmO9WnaXaX2bFnv80DS3YCOhAxoP1Wrd5UNZ6Kj) |
| **Frosted Input & Category List** | **Focus Glow Input & Liquid List** |

### 4. Favorites & Collection Screens
| Glassmorphism Favorites View | Liquid Glass Favorites View |
| :---: | :---: |
| ![Glassmorphism Favorites Screen](https://4wnv1si1gw.ufs.sh/f/AggufDazdUmO1vKgN1yJnlBfWCsU6DSLoz9FtgaiZjHPmX0x) | ![Liquid Glass Favorites Screen](https://4wnv1si1gw.ufs.sh/f/AggufDazdUmOVuycKGY4MoyNCW8A79Jnr2HUESORDFVlzcQg) |
| **Edge-to-Edge Frosted Favorites** | **Edge-to-Edge Glowing Favorites** |

### 5. Profile & Settings Screens
| Glassmorphism Profile View | Liquid Glass Profile View |
| :---: | :---: |
| ![Glassmorphism Profile Screen](https://4wnv1si1gw.ufs.sh/f/AggufDazdUmO0IXHBldmuLnFY21QEbZRih4VswTOSDfMIrpH) | ![Liquid Glass Profile Screen](https://4wnv1si1gw.ufs.sh/f/AggufDazdUmOfjQRIrbYLdb70MORD69e1BWl2vJFnf5kywos) |
| **Frosted Avatar & Account Options** | **Cyan Glow Avatar & Account Options** |

---

## 🌟 Glass UI Component Suite (`glass_ui_kit.dart`)

Developers can easily integrate standalone **Glass AppBars**, **Glass Buttons**, **Glass Switches**, **Glass Cards**, **Glass TextFields**, or **Widget Extensions**:

### 1. Dynamic Per-Tab AppBar Titles (`titles: List<String>`)
Pass custom titles directly per tab index or let the AppBar automatically switch between `"Dashboard"`, `"Search"`, `"Favorites"`, and `"Profile"`:

```dart
import 'package:liquid_morph_ui/glass_ui_kit.dart';

// Liquid Glass UI with Custom Titles per Tab
LiquidGlassUI(
  titles: const [
    'Dashboard',     // Tab Index 0 (Home)
    'Search Items',  // Tab Index 1 (Search)
    'My Favorites',  // Tab Index 2 (Favorites)
    'User Profile',  // Tab Index 3 (Profile)
  ],
  pages: myPages,
  items: myItems,
);
```

### 2. Pure Crystal Transparency in Liquid Glass
`LiquidGlassUI`, `LiquidGlassBottomNavBar`, `LiquidGlassCard`, and `LiquidGlassContainer` support 100% crystal transparency (`Colors.transparent`), allowing background gradients to shine through while active cyan liquid pills, specular sheen highlights, and icons float dynamically above the glass surface.

### 3. Standalone Glass Buttons (`GlassButton` & `LiquidGlassButton`)
Interactive buttons with frosted glass depth, glow shadows, and press animations:

```dart
// Classic Glassmorphism Button
GlassButton(
  label: 'Frosted Glass Button',
  icon: Icons.auto_awesome,
  onTap: () {},
);

// Liquid Glass Button with Cyan Glow
LiquidGlassButton(
  label: 'Liquid Glass Button',
  icon: Icons.water_drop,
  glowColor: Color(0x4038BDF8),
  onTap: () {},
);
```

### 4. Standalone Glass Toggle Switches (`GlassSwitch` & `LiquidGlassSwitch`)
Animated glass toggle switches with zero-clipping `AnimatedAlign` slider controls:

```dart
// Classic Glass Switch
GlassSwitch(
  value: isEnabled,
  onChanged: (val) => setState(() => isEnabled = val),
);

// Liquid Glass Glow Switch
LiquidGlassSwitch(
  value: isEnabled,
  activeGlowColor: Color(0xFF38BDF8),
  onChanged: (val) => setState(() => isEnabled = val),
);
```

### 5. Standalone Glass Input Text Fields (`GlassTextField` & `LiquidGlassTextField`)
Glass text fields with frosted borders and focus glow shadows:

```dart
// Glassmorphism Input Field
GlassTextField(
  hintText: 'Search anything...',
  prefixIcon: Icons.search,
);

// Liquid Glass Input Field with Focus Glow
LiquidGlassTextField(
  hintText: 'Enter password...',
  prefixIcon: Icons.lock_outline,
  obscureText: true,
  focusGlowColor: Color(0xFF38BDF8),
);
```

### 6. Standalone Glass Cards (`GlassCard` & `LiquidGlassCard`)
```dart
GlassCard(
  child: Text('Frosted Glass Card Content'),
);

LiquidGlassCard(
  glowColor: Color(0x3038BDF8),
  child: Text('Liquid Glass Card Content'),
);
```

### 7. Standalone Customizable `GlassAppBar`
```dart
// Classic Glassmorphism AppBar
GlassAppBar(
  title: 'Dashboard',
  leftButtons: [
    IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {}),
  ],
  rightButtons: [
    IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
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

### 8. Extension Methods on `Widget`
```dart
// Turn ANY widget into Frosted Glass in 1 line
const Text('Frosted Card').asGlass(blur: 15.0);

// Turn ANY widget into Liquid Glass in 1 line
const Text('Liquid Card').asLiquidGlass(glowColor: Color(0x3038BDF8));
```

---

## 🏗️ Senior Developer Architecture & OOP Design Patterns

This codebase is structured around production-grade **Clean Architecture** and classic **Gof Design Patterns**:

1. **Clean Architecture (Controller / BLoC vs Presentation)**:
   - Business logic, touch gestures, and physics state are encapsulated in `GlassNavigationController`, leaving UI widgets as pure presentation layers.
2. **Immutable Value State (`GlassNavigationState`)**:
   - Encapsulates active tab indices, drag coordinates, animation progress, and interaction flags into an immutable value object featuring `copyWith()`, value equality (`==`), and `hashCode`.
3. **Command Pattern (`GlassNavigationCommand`)**:
   - Encapsulates user interactions as executable commands: `SelectTabCommand`, `DragUpdateCommand`, and `DragEndCommand`.
4. **Observer Pattern & Scoped Dependency Injection (`GlassScope`)**:
   - Uses an `InheritedNotifier` scope providing scoped dependency injection of the state controller down the widget tree with reactive frame notifications.
5. **Strategy Pattern (`GlassNavigationEngine`)**:
   - Abstract engine strategy interface allowing dynamic swapping of tab physics and rendering strategies.
6. **Automated GitHub Actions CI/CD (`.github/workflows/ci_cd.yml`)**:
   - Runs automated formatting checks, static analysis, unit/widget tests, package dry-run validation, and automated publishing to `pub.dev` with automatic version git tagging on success.

---

## ⚡ Performance Highlights

- **`RepaintBoundary` Isolation**: The computationally heavy `BackdropFilter` layer is cached and isolated from rebuilds during animations.
- **Jump-Free Gesture Continuity**: Drag release captures current frame position (`_startCenterX`) so the capsule smoothly interpolates to the target tab without teleporting or snapping back.
- **`static const` Optimization**: All layout dimensions, colors, edge insets, text styles, and border decorations are compile-time constants.
- **Swift Package Manager (SPM)**: Native iOS dependency management configured via Swift Package Manager.

---

## 📁 Project Architecture

```text
lib/
├── liquid_morph_ui.dart               # Primary Package Export Entry Point
├── glass_ui_kit.dart                  # Alias Export Module (Backward Compatibility)
├── app.dart                           # Root MaterialApp Configuration (MyApp)
├── main.dart                          # Application Entry Point
├── glass_morphism_ui.dart             # Redirect Export to src/screens/
├── liquid_glass_ui.dart              # Redirect Export to src/screens/
├── main_home_screen.dart              # Redirect Export to src/screens/
├── glass_ui_contracts.dart           # Redirect Export to src/core/
└── src/                               # Internal Implementation Modules
    ├── core/                          # State Management, Controller & Contracts
    │   ├── glass_navigation_controller.dart
    │   ├── glass_scope.dart
    │   └── glass_ui_contracts.dart
    ├── models/                        # Immutable Data Models & Enums
    │   ├── bottom_navigation_item.dart
    │   └── glass_ui_style.dart
    ├── components/                    # Reusable Glass UI Components
    │   ├── glass_app_bar.dart
    │   ├── glass_bottom_navigation_bar.dart
    │   ├── glass_button.dart
    │   ├── glass_card.dart
    │   ├── glass_container.dart
    │   ├── glass_navigation_card.dart
    │   ├── glass_switch.dart
    │   └── glass_text_field.dart
    ├── extensions/                    # Extension Methods
    │   └── glass_widget_extension.dart
    └── screens/                       # Showcase Pages & Glass Dashboards
        ├── glass_morphism_ui.dart
        ├── liquid_glass_ui.dart
        └── main_home_screen.dart

test/                                  # Unit & Widget Test Suite
├── main_screen_test.dart              # Main HomeScreen Navigation Tests
├── glass_morphism_ui_test.dart        # GlassmorphismUI Widget Tests
├── liquid_glass_ui_test.dart          # LiquidGlassUI Widget Tests
├── glass_ui_kit_test.dart             # GlassUIKit Component Suite Tests
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
flutter pub add liquid_morph_ui
```

Or add to `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  liquid_morph_ui: ^1.0.6
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
